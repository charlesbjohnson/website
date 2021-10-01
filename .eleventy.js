module.exports = (eleventy) => {
  const cfg = {
    dir: {
      input: ".",
      output: "./dist",
      layouts: "_layouts",
    },
  };

  eleventy.addPassthroughCopy("./stylesheets");

  eleventy.ignores.add("README.md")

  return cfg;
};
