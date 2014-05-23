class BaseJourney

  def initialize (browser, automator, offset, domain)
    @browser = browser
    @automator = automator
    @offsetX = offset[:x]
    @offsetY = offset[:y]
    @domain = domain
  end

  def getScrollPos
    res = @browser.execute_script <<-JS
      return {
        scrollTop: $(window).scrollTop(),
        scrollLeft: $(window).scrollLeft(),
      }
    JS
    return [res['scrollLeft'].to_i, res['scrollTop'].to_i]
  end

  def moveMouse (x, y)
    pos = getScrollPos
    x += @offsetX - pos[0]
    y += @offsetY - pos[1]
    @automator.mouse_move(x, y)
  end

  def scrollToEl(el, options = {})
    lefttop = el.wd.location
    size = el.wd.size
    centre = [lefttop[0] + size[0] / 2, lefttop[1] + size[1] / 2]
    rightbottom = [lefttop[0] + size[0], lefttop[1] + size[1]]
    res = @browser.execute_script <<-JS
      return {
        windowWidth: $(window).width(),
        windowHeight: $(window).height(),
        scrollTop: $(window).scrollTop(),
        scrollLeft: $(window).scrollLeft(),
      }
    JS

    scrollLeft = res['scrollLeft'].to_i
    scrollTop = res['scrollTop'].to_i

    visible_lefttop = [scrollLeft, scrollTop]
    visible_rightbottom = [scrollLeft + res['windowWidth'].to_i, scrollTop + res['windowHeight'].to_i]

    # is element fully visible?
    visible_horizontal = visible_lefttop[0] <= lefttop[0] && rightbottom[0] <= visible_rightbottom[0]
    visible_vertical = visible_lefttop[1] <= lefttop[1] && rightbottom[1] <= visible_rightbottom[1]


    if !visible_vertical
      scrollTop = centre[1] - res['windowHeight'].to_i / 2
      @browser.execute_script <<-JS
        $('html, body').animate({
            scrollTop: #{scrollTop},
            scrollLeft: #{scrollLeft}
          },
          {
            duration: 900,
            easing: 'swing'
          });
      JS
      sleep 1.0
    end
  end

  def getPositionOnEl(el, options = {})
    lefttop = el.wd.location
    size = el.wd.size
    horizontal = options[:horizontal] || 0.8
    vertical = options[:vertical] || 0.7
    pos = [lefttop[0] + size[0] * horizontal, lefttop[1] + size[1] * vertical]
  end

  def moveToEl(el, options = {})
    scrollToEl(el, options)
    pos = getPositionOnEl(el, options)
    moveMouse(pos[0], pos[1])

    if options[:click]
      sleep 0.5
      showClick(pos[0], pos[1])
      el.click
    end
  end

  def showClick(x, y)
    pos = getScrollPos
    x -= pos[0]
    y -= pos[1]

    size = 100.0
    @browser.execute_script <<-JS
      (function () {
        var circle = $('<div>').html('&nbsp');
        circle.css({
          'box-sizing': 'border-box',
          'border-radius': '50%',
          width: '0px',
          height: '0px',
          border: '2px red solid',
          background: 'rgba(255,0,0, 0.6)',
          position: 'fixed',
          opacity: 1,
          top: #{y},
          left: #{x},
          'z-index': 10000
        });
        circle.appendTo('body');
        circle.animate({
          width: '#{size}px',
          height: '#{size}px',
          'margin-left': '-#{size / 2.0}px',
          'margin-top': '-#{size / 2.0}px',
          opacity: 0
        }, 500, function () {
          circle.remove();
        });
      })()
    JS
    sleep 0.6
  end

  def message(text, options = {})
    duration = options[:duration]
    duration ||= 6000
    fadeIn = options[:fadeIn]
    fadeIn ||= 800
    fadeOut = options[:fadeOut]
    fadeOut ||= 800
    @browser.execute_script <<-JS
      (function () {
        var message = $('<div>').html('#{text}');
        message.css({
          'box-sizing': 'border-box',
          padding: '3% 4% 2%',
          position: 'fixed',
          width: '94%',
          left: '3%',
          bottom: '3%',
          display: 'block',
          'font-size': '70px',
          background: 'rgba(0,0,0,0.8)',
          margin: 0,
          color: 'white',
          'z-index': '10000',
          'line-height': '100%',
          'box-shadow': '5px 5px 17px rgba(0,0,0,.5)',
          'border-radius': '30px'
        });
        message.appendTo('body').hide();
        message.fadeIn(#{fadeIn}, function () {
          setTimeout(function () {
            message.fadeOut(#{fadeOut}, function () {
              message.remove();
            });
          }, #{duration});
        });
      })()
    JS

    sleep (duration + fadeIn + fadeOut) / 1000

  end
end
