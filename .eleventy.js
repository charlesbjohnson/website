module.exports = (eleventy) => {
  const cfg = {
    dir: {
      input: "./src",
      output: "./dist",
      layouts: "_layouts",
    },
  };

  eleventy.addPassthroughCopy("./src/stylesheets");

  return cfg;
};
