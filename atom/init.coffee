# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-text-editor',
  'editor:fold-current-row-toggle': (event) ->
    editor = @getModel()
    bufferRow = editor.bufferPositionForScreenPosition(editor.getCursorScreenPosition()).row
    if editor.isFoldedAtBufferRow(bufferRow)
      editor.unfoldBufferRow(bufferRow)
    else
      editor.foldBufferRow(bufferRow)

atom.commands.add 'atom-text-editor',
  'editor:fold-all-toggle': (event) ->
    editor = @getModel()
    bufferRow = editor.bufferPositionForScreenPosition(editor.getCursorScreenPosition()).row
    if editor.isFoldedAtBufferRow(bufferRow)
      editor.unfoldAll()
    else
      editor.foldAll()

atom.commands.add 'atom-text-editor',
  'editor:open-wiki-index': (event) ->
    atom.workspace.open '0-personal.md'

atom.commands.add 'atom-text-editor',
  'editor:current-link': (event) ->
    editor = @getModel()
    cursor = editor.getCursors()[0]
    point = cursor.getBufferPosition()
    text = editor.lineTextForBufferRow(point.row)
    match = text.match /\[.*\]\((.*)\)/
    #test [mylink](hello.md)
    console.log editor.lineTextForBufferRow()

atom.commands.add 'atom-text-editor',
  'editor:generate-journal': (event) ->
    editor = @getModel()
    startDate = new Date(2015, 11)
    now = new Date(startDate)
    days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
    output = '### TASKS ###\n\n'
    output += '- DANE\n\n'
    output += '- RAE\n\n'
    output += '### PROJECTS ###\n\n\n\n'

    while (now.getMonth() == startDate.getMonth())
      output += '### '
      date = now.getDate()
      output += '0' if date < 10
      output += date + ' '
      output += days[now.getDay()].toString() + ' ###\n\n'
      output += '- DANE\n\n'
      output += '- RAE\n\n'
      now.setDate(date+1)

    editor.insertText(output)

atom.commands.add 'atom-text-editor',
  'editor:generate-personal-journal': (event) ->
    editor = @getModel()
    startDate = new Date(2015, 10)
    now = new Date(startDate)
    days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
    output = ''

    while (now.getMonth() == startDate.getMonth())
      output += '## '
      date = now.getDate()
      output += '0' if date < 10
      output += date + ' '
      output += days[now.getDay()].toString() + '\n\n'
      if now.getDay() == 6
        output += '---\n\n'
      now.setDate(date+1)

    editor.insertText(output)

atom.commands.add 'atom-text-editor',
  'editor:toggle-line-comments-vi': (event) ->
    editor = @getModel()
    atom.commands.dispatch(atom.views.getView(editor), 'editor:toggle-line-comments')
    atom.commands.dispatch(atom.views.getView(editor), 'vim-mode:reset-normal-mode')
