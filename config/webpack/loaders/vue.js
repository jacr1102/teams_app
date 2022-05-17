const process = require('process')
const {dev_server: devServer} = require('@rails/webpacker').config

module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader'
  }]
}
