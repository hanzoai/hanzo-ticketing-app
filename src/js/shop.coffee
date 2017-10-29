import Shop from 'shop.js/src'
import $ from 'zepto-modules/_min'

import checkoutHtml from '../_checkout'

# This has to be delayed and added at runtime due to astley
$('#checkout').html checkoutHtml

requestAnimationFrame ->
  m = Shop.start
    key: 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJiaXQiOjQ1MDM2MTcwNzU2NzUxNzYsImp0aSI6ImlKOXpkQ3RxNFNVIiwic3ViIjoicEdUUlJSeDlJQiJ9.J7uLpqjd4eBUYyWzRqhv2dzciKR_Lf5ETHpJeZ9_9vil-KRbEv0gLwKcLLxVrQRqW2ceFZfM5c6NLqAwncAJIw'
    processor: 'ethereum'
    currency: 'eth'

  m.on 'ready', ->
    if !Shop.getItem('ticket20171031').quantity
      Shop.setItem('ticket20171031', 1)
