import El from 'el.js'

import metamaskHtml from '../_metamask'

class PayWithMetaMask extends El.Form
  tag: 'paywithmetamask'
  html: metamaskHtml
  init: ()->
    super
