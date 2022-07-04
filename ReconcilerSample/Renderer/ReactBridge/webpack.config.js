const path = require("path");

module.exports =
	{
		mode: "development",
		entry: {
			index: path.join(__dirname, "src", "index.jsx"),
		},
		output: {
			path: path.join(__dirname, "dist"),
			filename: "main.js",
		},
		module: {
			rules: [
				{
					test: /\.jsx?$/,
					exclude: /node_modules/,
					use: {
						loader: "babel-loader",
						options: {
							presets: ["@babel/preset-env", "@babel/preset-react"],
						},
					},
				},
			],
		},
	};
