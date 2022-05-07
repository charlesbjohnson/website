# frozen_string_literal: true

module SSG
  class Server
    def initialize
      self.lock = Thread::Mutex.new

      self.http = WEBrick::HTTPServer.new(BindAddress: Site.config.serve_host, Port: Site.config.serve_port)
      http.mount_proc("/") do |request, response|
        lock.synchronize do
          handle(request, response)
        end
      end

      self.listener = Listen.to(Site.config.dir_in) do
        lock.synchronize do
          reload
        end
      end
    end

    def start
      listener.start
      http.start

      nil
    end

    def stop
      listener.stop
      http.stop

      nil
    end

    private

    def handle(request, response)
      document = routes[request.path]

      case document
      when String
        response.set_redirect(WEBrick::HTTPStatus::MovedPermanently, document)
      when Page
        response.body = document.render
      when File
        response.body = document.content
      else
        raise(WEBrick::HTTPStatus::NotFound, "`#{request.path}' not found.")
      end
    end

    def reload
      Site.reboot
      routes(force: true)
    end

    def routes(force: false)
      @routes = {} if !defined?(@routes) || force
      return @routes unless @routes.empty?

      Site.pages.each do |page|
        output = Page::Output.new(page)
        output.uris.map(&:to_s).each do |uri|
          @routes[uri] = page

          if uri.end_with?("/")
            @routes[uri.chomp("/")] = uri == "/" ? page : uri
          end
        end
      end

      Site.files.each_value do |file|
        output = File::Output.new(file)
        @routes[output.uri.to_s] = file
      end

      @routes
    end

    attr_accessor :http, :listener, :lock
  end
end
