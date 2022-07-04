module.exports = {
    mode: "development",
  
    entry: "./src/index.jsx",
    output: {
      filename: "todo.js"
    },
  
    module: {
      rules: [
        {
          test: /\.jsx?$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env', '@babel/preset-react']
            }
          }
        }
      ]
    },
    target: ["node"],
  };
  
