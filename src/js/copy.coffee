import El   from 'el.js'
import html from './templates/_copy'

export class CopyControl extends El.View
  tag: 'copybox'
  html: html

  # pass this in
  text: ''

  # this is set automatically
  copied: false

  init: ()->
    super

  getText: ()->
    if typeof @text == 'function'
      return @text()

    return @text

  copy: (e)->
    text = @getText()

    textArea = document.createElement "textarea"

    textArea.style.position = 'fixed'
    textArea.style.top = 0
    textArea.style.left = 0
    textArea.style.width = '2em'
    textArea.style.height = '2em'
    textArea.style.padding = 0
    textArea.style.border = 'none'
    textArea.style.outline = 'none'
    textArea.style.boxShadow = 'none'
    textArea.style.background = 'transparent'
    textArea.value = text
    document.body.appendChild textArea
    textArea.select()

    try
      successful = document.execCommand 'copy'
      msg = successful ? 'successful' : 'unsuccessful'
      console.log 'Copying text command was ' + msg
    catch err
      console.log 'Oops, unable to copy'

    document.body.removeChild textArea

    @copied = true

    @scheduleUpdate()

CopyControl.register()
