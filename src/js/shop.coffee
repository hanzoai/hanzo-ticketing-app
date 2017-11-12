import Shop   from 'shop.js/src'
import $      from 'zepto-modules/_min'
import moment from 'moment'
import Xhr    from 'es-xhr-promise'

import checkoutHtml from '../_checkout'

# This has to be delayed and added at runtime due to astley
$('#checkout').html checkoutHtml

requestAnimationFrame ->
  m = Shop.start
    # test
    # key: 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJiaXQiOjQ1MDM2MTcwNzU2NzUxNzYsImp0aSI6ImlKOXpkQ3RxNFNVIiwic3ViIjoicEdUUlJSeDlJQiJ9.J7uLpqjd4eBUYyWzRqhv2dzciKR_Lf5ETHpJeZ9_9vil-KRbEv0gLwKcLLxVrQRqW2ceFZfM5c6NLqAwncAJIw'

    # live
    key: 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJiaXQiOjQ1MDM2MTcwNzU2NzUxNzIsImp0aSI6InJtcGJpLVNocW1BIiwic3ViIjoicEdUUlJSeDlJQiJ9.gGDFpgimwhoeUONSBLuYX_Arla23n0Iw2-V4qw7Iq0ZJU4IfX3Vy7Pruu2wTmMe0e1VGK3owZ0F73QNG-pwTGg'
    processor: 'ethereum'
    currency: 'eth'

  data = Shop.getData()
  data.set 'terms', true

  # pick between eth and credit card
  window.paymentSelected = ''

  window.selectEth = ()->
    window.paymentSelected = 'eth'
    data.set 'order.type', 'ethereum'
    data.set 'payment.type', 'ethereum'
    data.set 'order.items.0.price', 50000000
    data.set 'order.currency', 'eth'
    data.set 'order.storeId', ''
    data.set 'user.storeId', ''
    Shop.cart.invoice()
    Shop.El.scheduleUpdate()

  window.selectStripe = ()->
    window.paymentSelected = 'stripe'
    data.set 'order.type', 'stripe'
    data.set 'payment.type', 'stripe'
    data.set 'order.items.0.price', 1750
    data.set 'order.currency', 'usd'
    data.set 'order.storeId', 'petWngPySWWWp1'
    data.set 'user.storeId', 'petWngPySWWWp1'
    Shop.cart.invoice()
    Shop.El.scheduleUpdate()

  # (new Xhr).send(
  #   url:    'https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD'
  #   method: 'get'
  # ).then (res) ->
  #   conversion = (JSON.parse res.responseText)
  #   window.usdConversion = conversion.USD
  #   Shop.El.scheduleUpdate()

  currentTicket = 'ticket20171114'

  m.on 'ready', ->
    if !Shop.getItem(currentTicket).quantity
      Shop.clear()
      Shop.setItem(currentTicket, 1)

  m.on 'submit-success', (order)->
    data.set 'order', order
    Shop.El.scheduleUpdate()

    setInterval ()->
      Shop.El.scheduleUpdate()
    , 1000

  testTime = moment().add(24, 'hours').subtract(1, 'seconds').unix()

  pad = (num) ->
    str = "#{num}"
    if str.length == 1
      str = "0#{num}"

    return str

  window.countdown = ->
    createdAt = data.get('order.createdAt')

    if createdAt?
      eventTime = moment(createdAt).add(24, 'hours').subtract(1, 'seconds').unix()
    else
      eventTime = testTime

    currentTime = moment().unix()

    timeLeft = moment.duration (eventTime - currentTime) * 1000, 'milliseconds'

    h = moment.duration(timeLeft).hours()
    m = pad(moment.duration(timeLeft).minutes())
    s = pad(moment.duration(timeLeft).seconds())

    return "#{h}:#{m}:#{s}"
