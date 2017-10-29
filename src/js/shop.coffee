import Shop   from 'shop.js/src'
import $      from 'zepto-modules/_min'
import moment from 'moment'

import checkoutHtml from '../_checkout'

# This has to be delayed and added at runtime due to astley
$('#checkout').html checkoutHtml

requestAnimationFrame ->
  m = Shop.start
    key: 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJiaXQiOjQ1MDM2MTcwNzU2NzUxNzYsImp0aSI6ImlKOXpkQ3RxNFNVIiwic3ViIjoicEdUUlJSeDlJQiJ9.J7uLpqjd4eBUYyWzRqhv2dzciKR_Lf5ETHpJeZ9_9vil-KRbEv0gLwKcLLxVrQRqW2ceFZfM5c6NLqAwncAJIw'
    processor: 'ethereum'
    currency: 'eth'

  data = Shop.getData()

  m.on 'ready', ->
    if !Shop.getItem('ticket20171031').quantity
      Shop.setItem('ticket20171031', 1)

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
