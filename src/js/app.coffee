import $ from 'zepto-modules/_min'

# astley needs to be executed before shop.js sequentially
import './astley'
import './shop'

window?.$ = $

switch location.pathname.substr(1).split('/')[0]
  when '', 'index'
    # /index logic
    #
    # cycle through background images

    classes = ['img1', 'img2', 'img3']
    i = 0

    cycleI = setInterval ->
      $hero = $('.hero')
      $hero.addClass 'animation-clear'

      setTimeout ->
        $hero.removeClass classes[i]
        $hero.removeClass 'animation-clear'
        i = (i + 1) % classes.length
        $hero.addClass classes[i]
      , 1000
    , 5000
