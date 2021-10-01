---
layout: default
title: Style Guide
description: Charles B Johnson's internet presence
favicon: 🎨
---

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5

<hr />

## Description
Lorem
  ~ Ipsum dolor

Lorem
  ~ Ipsum dolor
  ~ Sit amet

Lorem
Ipsum
  ~ Dolor

## Ordered
1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
2. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

## Unordered
1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
2. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

<hr />

## Figure
<figure>
  <img src="{{ '/images/800x450.jpg' | url }}" />
  <figcaption>A placeholder image.</figcaption>
</figure>

<hr />

## Blockquote
<blockquote cite="https://loremipsum.io">
  <p>
    &ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Magna ac
    placerat vestibulum lectus mauris ultrices. Vehicula ipsum a arcu
    cursus. Rhoncus aenean vel elit scelerisque.&rdquo;
  </p>

  <footer>
    <cite>Lorem Ipsum Generator</cite>
  </footer>
</blockquote>

> This is an info callout. {data-level=info}

> This is an warning callout. {data-level=warning}

> This is an error callout. {data-level=error}

<hr />

## Code
<code>hello_world</code>
<br />
<br />

<kbd>Ctrl-c</kbd>

<pre data-name="hello.rb">
  {{- '' -}}
  <code>
    {{- '' -}}
def hello_world
puts("Hello World!")
end

hello_world
    {{- '' -}}
  </code>
  {{- '' -}}
</pre>

<pre data-lang="ruby">
  {{- '' -}}
  <code>
    {{- '' -}}
def goodbye_world
puts("Goodbye World!")
end

goodbye_world
    {{- '' -}}
  </code>
  {{- '' -}}
</pre>

<pre>
  {{- '' -}}
  <samp>
    {{- '' -}}
foo@bar ~/baz > <kbd>echo "Hello World"</kbd>
Hello World
    {{- '' -}}
  </samp>
  {{- '' -}}
</pre>

<hr />

## Link
- <a href="#">Link</a>
- Footnote<sup><a href="#fn:1">[1]</a></sup>

References:
<ol>
  <li id="fn:1">
    <p>Reference <a href="#fnref:1">↩︎</a></p>
  </li>
</ol>

<hr />

<h2>Emphasis</h2>
<ul>
  <li><strong>Strong</strong> or <b>Bold</b></li>
  <li><em>Emphasis</em> or <i>Italic</i></li>
  <li><del>Delete</del> or <s>Strikethrough</s></li>
  <li><ins>Insert</ins> or <u>Underline</u></li>
  <li><abbr title="Abbreviated">Abbrev</abbr></li>
  <li><mark>Mark</mark></li>
  <li><small>Small</small></li>
</ul>
