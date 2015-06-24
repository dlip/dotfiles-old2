WikiLinkView = require './wiki-link-view'
require('date-utils')
{CompositeDisposable} = require 'atom'
path = require('path')
fs = require('fs')

module.exports = WikiLink =
  wikiLinkView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wikiLinkView = new WikiLinkView(state.wikiLinkViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wikiLinkView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wiki-link:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wikiLinkView.destroy()

  serialize: ->
    wikiLinkViewState: @wikiLinkView.serialize()

  toggle: ->
    return unless editor = atom.workspace.getActiveTextEditor()
    return unless file = editor?.buffer.file

    selection = editor.getLastSelection()

    date = new Date().toFormat('YYYY-MM-DD_HH24-MI-SS');

    newFilename = "#{date}.md"
    newFilePath = path.join path.dirname(file.path), newFilename

    selection.insertText("[#{selection.getText()}](#{newFilename})")

    fs.openSync(newFilePath, 'w')
    fs.closeSync fs.openSync(newFilePath, 'w')

    atom.workspace.open newFilePath

    return
    console.log 'WikiLink was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
