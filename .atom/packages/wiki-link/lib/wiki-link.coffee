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
    @subscriptions.add atom.commands.add 'atom-workspace', 'wiki-link:generate-todo': => @generateTodo()

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

  generateTodo: ->
    return unless editor = atom.workspace.getActiveTextEditor()
    return unless file = editor?.buffer.file
    todoRegex = /\s*(- \[ \] !.*)/
    todoFilename = '3-todo.md'

    filePath = path.dirname(file.path)
    todoFilePath = path.join filePath, todoFilename

    console.log "Generating todo"

    todos = new Array()
    fileList = new Array()

    allFiles = fs.readdirSync filePath

    allFiles.forEach (f) ->
      if f.match(/\.md$/) && f != todoFilename
        fileList.push f

    fileList.forEach (f) ->
      fileLocation = path.join filePath, f
      console.log "reading " + fileLocation
      data = fs.readFileSync fileLocation, { flag: 'r', encoding: 'utf8' }
      title = "From"
      data.toString().split(/\n/).forEach (line) ->
        if (title == "From")
          titleMatch = line.match /^#\s*(.*)/
          if titleMatch
            title = titleMatch[1]
        match = line.match todoRegex
        if match
          todos.push match[1] + " [#{title}](#{f})"

    todos.sort()

    fs.writeFile todoFilePath, '# Todo\n\n' + todos.join("\n"), {flag: 'w+'}, (err) ->
      throw err if err
      console.log('It\'s saved!')
      atom.workspace.open todoFilePath
    return
