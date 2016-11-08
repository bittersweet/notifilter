"use strict";

var ExtractText = require("extract-text-webpack-plugin");

module.exports = {
  entry: "./web/static/js/index.js",
  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },

  module: {
    loaders: [
      {
        test: /\.scss$/,
        loader: ExtractText.extract("style", "css!sass"),
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        }
      }
    ]
  },
  plugins: [
    new ExtractText("../css/app.css", {
      allChunks: true
    })
  ],
};
