{CompositeDisposable} = require 'atom'
path = require('path')
fs = require('fs')
moment = require('moment')

module.exports = WikiLink =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wiki-link:link-text': => @linkText()

  deactivate: ->
    @subscriptions.dispose()

  createLink: (linkText) ->
    return unless editor = atom.workspace.getActiveTextEditor()
    return unless file = editor?.buffer.file

    selection = editor.getLastSelection()

    date = moment().format('YYYYMMDDHHmmss')

    newFilename = "#{date}.md"
    newFilePath = path.join path.dirname(file.path), newFilename

    selection.insertText("[#{linkText}](#{newFilename})")

    fs.writeFile newFilePath, "# #{linkText}\n\n", (err) ->
      throw err if err
      console.log('It\'s saved!')
      atom.workspace.open newFilePath, { initialLine: 2 }
    return

  linkText: ->
    return unless editor = atom.workspace.getActiveTextEditor()

    selection = editor.getLastSelection()
    selectionText = selection.getText()

    if selectionText.length == 0
      selectionText = moment().format('YYYY-MM-DD ddd')

    @createLink selectionText
