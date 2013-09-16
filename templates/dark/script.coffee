$ ->

  #
  # navigation
  #

  $.fn.currentSlide = ->
    @removeClass('past future').addClass 'current'
    @prevAll().removeClass('current future').addClass 'past'
    @nextAll().removeClass('current past').addClass 'future'

  $.fn.next_loop = ->
    $next = @next()
    return $next if $next.length
    @siblings().first()

  $.fn.prev_loop = ->
    $prev = @prev()
    return $prev if $prev.length
    @siblings().last()

  #
  # keyboard triggers
  #

  next_slide = ->
    $('#slides .current').next_loop().currentSlide()
    animation_hook()

  prev_slide = ->
    $('#slides .current').prev_loop().currentSlide()
    animation_hook()

  $(window).on 'keydown', (e) ->
    switch e.keyCode
      when 39 then next_slide()
      when 37 then prev_slide()

  #
  # animation hooks
  #

  animation_hook = ->
    switch $('#slides').attr('class').split(' ')[0]
      when 'slide'
        slide_width = $('#slides div').width()
        $('.future').css(left: window.innerWidth + slide_width)
        $('.past').css(left: -window.innerWidth - slide_width)
        $('.current').css(left: 0)

    setTimeout (-> $('#slides').addClass('loaded')), 1

  pin_slides = ->
    for s in $('#slides div')
      if $(s).has('h3').length then $(s).addClass('pinned')

  #
  # initialize
  #

  $('#slides div').addClass 'future'
  $('#slides div:first').currentSlide()
  pin_slides()
  animation_hook()