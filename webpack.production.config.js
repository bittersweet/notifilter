"use strict";

var webpack = require('webpack');
var ExtractText = require("extract-text-webpack-plugin");

module.exports = {
  entry: "./web/static/js/index.js",
  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV || 'production')
    }),
    new ExtractText("../css/app.css", {
      allChunks: true
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new ExtractText("../css/app.css", {
      allChunks: true
    }),
  ],
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
};
