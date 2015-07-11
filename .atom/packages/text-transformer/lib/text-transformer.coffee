{CompositeDisposable} = require 'atom'
csvToMarkdown = require './csv-to-markdown'
sanitizeHtml = require('sanitize-html')
toMarkdown = require('to-markdown')

module.exports = TextTransformer =
  textTransformerView: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'text-transformer:csv-to-markdown': => @textTransform @csvToMarkdown
    @subscriptions.add atom.commands.add 'atom-workspace', 'text-transformer:html-sanitize': => @textTransform @htmlSanitize
    @subscriptions.add atom.commands.add 'atom-workspace', 'text-transformer:html-to-markdown': => @textTransform @htmlToMarkdown
    @subscriptions.add atom.commands.add 'atom-workspace', 'text-transformer:paste-html-to-sanitized-markdown': => @textTransform [@htmlSanitize, @htmlToMarkdown], true

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    textTransformerViewState: @textTransformerView.serialize()

  textTransform: (filters, fromClipboard) ->
    return unless editor = atom.workspace.getActiveTextEditor()
    if typeof filters is 'function'
      filters = [filters]

    buf = editor.getBuffer()
    selection = editor.getLastSelection()
    if selection.isEmpty()
      editor.selectAll()
      selection = editor.getLastSelection()

    text = ""
    if fromClipboard
      text = atom.clipboard.read()
    else
      text = selection.getText()

    eol = buf.lineEndingForRow(0);
    result = text
    for filter in filters
      result = filter(result, eol)

    insertOpt =
      normalizeLineEndings: true
      autoIndent: false
      autoIndentNewline: false

    selection.insertText result, insertOpt

  csvToMarkdown: (text, eol) ->
    csvToMarkdown text, ',', true, eol

  htmlSanitize: (text, eol) ->
    sanitizeHtml text,
      allowedTags: [ 'img', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'blockquote', 'p', 'a', 'ul', 'ol', 'nl', 'li', 'b', 'i', 'strong', 'em', 'strike', 'code', 'hr', 'br', 'div', 'table', 'thead', 'caption', 'tbody', 'tr', 'th', 'td', 'pre' ],
      transformTags:
        'div': 'p'

  htmlToMarkdown: (text, eol) ->
    toMarkdown text
