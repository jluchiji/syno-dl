app = require 'app'
window = require 'window'

# Report crashes to GitHub
require('crash-reporter').start()

# Global reference of the main window
mainWindow = null

# Quit when all windows closed
app.on 'window-all-closed', ->
  app.quit() if process.platform isnt 'darwin'

# Initialized and ready
app.on 'ready', ->

  # Create the main window
  mainWindow = new window width:800, height:600

  # Load the url
  mainWindow.loadUrl 'file://' + __dirname + '/index.html'

  # Dereference when window closed
  mainWindow.on 'closed', ->
    mainWindow = null
