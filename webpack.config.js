module.exports = {
  entry: "./web/static/js/index.js",
  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        }
      }
    ]
  }
};
