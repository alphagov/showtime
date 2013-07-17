class BaseJourney
  def initialize (browser, automator, offset)
    @browser = browser
    @automator = automator
    @offsetX = offset[:x]
    @offsetY = offset[:y]
  end

  def moveMouse (x, y)
    res = @browser.execute_script <<-JS
      return {
        scrollTop: $(window).scrollTop(),
        scrollLeft: $(window).scrollLeft(),
      }
    JS
    x += @offsetX - res['scrollLeft'].to_i
    y += @offsetY - res['scrollTop'].to_i
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

  def moveToEl(el, options = {})
    scrollToEl(el, options)
    lefttop = el.wd.location
    size = el.wd.size
    centre = [lefttop[0] + size[0] / 2, lefttop[1] + size[1] / 2]
    moveMouse(centre[0], centre[1])

    if options[:click]
      el.click
    end
  end
end
