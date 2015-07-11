{CompositeDisposable} = require 'atom'
csvToMarkdown = require './csv-to-markdown'

module.exports = TextTransformer =
  textTransformerView: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'text-transformer:csv-to-markdown': => @csvToMarkdown()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    textTransformerViewState: @textTransformerView.serialize()

  csvToMarkdown: ->
    return unless editor = atom.workspace.getActiveTextEditor()
    
    buf = editor.getBuffer()
    selection = editor.getLastSelection()
    if selection.isEmpty()
      editor.selectAll()
      selection = editor.getLastSelection()
    text = selection.getText()

    eol = buf.lineEndingForRow(0);
    md = csvToMarkdown text, ',', true, eol
    insertOpt =
      normalizeLineEndings: true
      autoIndent: false
      autoIndentNewline: false

    selection.insertText md, insertOpt
