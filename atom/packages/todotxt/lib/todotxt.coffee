{Point,Range} = require 'atom'
{CompositeDisposable} = require 'atom'

module.exports = Todotxt =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'todotxt:increase-priority': => @changePriority(-1, "A")
    @subscriptions.add atom.commands.add 'atom-workspace', 'todotxt:decrease-priority': => @changePriority(1, "Z")

  deactivate: ->
    @subscriptions.dispose()

  sortLines: ->
    return unless editor = atom.workspace.getActiveTextEditor()
    cursor = editor.getCursors()[0]
    point = cursor.getBufferPosition()
    textLines = editor.getText().split("\n")

    x = 0;
    textLines = textLines.map (o) -> [x++, o]
    textLines = textLines.sort (a, b) -> a[1].localeCompare(b[1])
    textLines = textLines.filter (a) -> a[1].length > 0
    newRow = 0
    for line, index in textLines
      if line[0] == point.row
        newRow = index
        break

    textLines = textLines.map (o) -> o[1]
    textLines = textLines.join("\n")
    editor.setText(textLines)
    editor.setCursorScreenPosition(new Point(newRow, point.column))


  changePriority: (offset, maxPriority)->
    return unless editor = atom.workspace.getActiveTextEditor()
    bufferRow = editor.bufferPositionForScreenPosition(editor.getCursorScreenPosition()).row
    text = editor.lineTextForBufferRow(bufferRow)
    match = text.match /^\(([A-Z])\)/
    if match
      priority = match[1]
      if priority == maxPriority
        return
      nextPriority = String.fromCharCode(priority.charCodeAt(0) + offset)
      range = new Range(new Point(bufferRow, 1), new Point(bufferRow, 2))
      editor.setTextInBufferRange(range, nextPriority)
    else
      if text.trim() == ""
        return
      range = new Range(new Point(bufferRow, 0), new Point(bufferRow, 0))
      editor.setTextInBufferRange(range, "(" + maxPriority + ") ")

    @sortLines()
