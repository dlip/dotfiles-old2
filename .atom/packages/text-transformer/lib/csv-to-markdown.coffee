###*
# Converts CSV to Markdown Table
# From https://github.com/donatj/CsvToMarkdownTable/blob/master/src/CsvToMarkdown.js
#
# @param {string} csvContent - The string content of the CSV
# @param {string} delimiter - The character(s) to use as the CSV column delimiter
# @param {boolean} hasHeader - Whether to use the first row of Data as headers
# @returns {string}
###
module.exports = (csvContent, delimiter, hasHeader, eol) ->
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
