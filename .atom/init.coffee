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
  'editor:csv-to-markdown': (event) ->

    ###*
    # Converts CSV to Markdown Table
    # From https://github.com/donatj/CsvToMarkdownTable/blob/master/src/CsvToMarkdown.js
    #
    # @param {string} csvContent - The string content of the CSV
    # @param {string} delimiter - The character(s) to use as the CSV column delimiter
    # @param {boolean} hasHeader - Whether to use the first row of Data as headers
    # @returns {string}
    ###
    csvToMarkdown = (csvContent, delimiter, hasHeader, eol) ->
      if delimiter != '\t'
        csvContent = csvContent.replace(/\t/g, '    ')
      columns = csvContent.split(eol)
      tabularData = []
      maxRowLen = []
      columns.forEach (e, i) ->
        if typeof tabularData[i] == 'undefined'
          tabularData[i] = []
        # Fix quoted escapes
        match = e.match /"(.*?)"/g
        if match
          match.forEach (m) ->
            res = m.replace /,/g, '@@'
            e = e.replace m, res
        row = e.split(delimiter)
        row.forEach (ee, ii) ->
          if typeof maxRowLen[ii] == 'undefined'
            maxRowLen[ii] = 0
          maxRowLen[ii] = Math.max(maxRowLen[ii], ee.length)
          tabularData[i][ii] = ee
          return
        return
      headerOutput = ''
      seperatorOutput = ''
      maxRowLen.forEach (len) ->
        spacer = undefined
        spacer = Array(len + 1 + 2).join('-')
        seperatorOutput += '|' + spacer
        spacer = Array(len + 1 + 2).join(' ')
        headerOutput += '|' + spacer
        return
      headerOutput += '| ' + eol
      seperatorOutput += '| ' + eol
      if hasHeader
        headerOutput = ''
      rowOutput = ''
      initHeader = true
      tabularData.forEach (col) ->
        maxRowLen.forEach (len, y) ->
          row = if typeof col[y] == 'undefined' then '' else col[y]
          spacing = Array(len - (row.length) + 1).join(' ')
          if hasHeader and initHeader
            headerOutput += '| ' + row + spacing + ' '
          else
            rowOutput += '| ' + row + spacing + ' '
          return
        if hasHeader and initHeader
          headerOutput += '| ' + eol
        else
          rowOutput += '| ' + eol
        initHeader = false
        return
      result = headerOutput + seperatorOutput + rowOutput
      result = result.replace /@@/g, ','
      result = result.replace /"/g, ''
      result

    # Atom code
    editor = @getModel()
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
