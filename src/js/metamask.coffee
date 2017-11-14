import El from 'el.js'

import metamaskHtml from './templates/_metamask'

class PayWithMetaMask extends El.Form
  tag: 'paywithmetamask'
  html: metamaskHtml
  init: ()->
    super

  # pay: (e)->
  #   if typeof web3 === 'undefined'
  #     return alert('You need to install MetaMask to use this feature.  https://metamask.io')

  #   user_address = web3.eth.accounts[0]
  #   web3.eth.sendTransaction
  #     to: YOUR_ADDRESS,
  #     from: user_address,
  #     value: web3.toWei('1', 'ether'),
  #   , (err, transactionHash)->
  #     if (err) return alert('Oh no!: ' + err.message)
