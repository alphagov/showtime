require 'watir-webdriver'

module Showtime
  class Journey

    def initialize(options={ :size => '960,600', :position => '0,0' }, &block)
      start_browser(options)
      begin
        while true
          instance_eval &block
        end
      rescue Watir::Exception::UnknownObjectException, Timeout::Error => e
        puts e.message
        retry
      ensure
        @browser.quit
      end
    end

    def start_browser(options)
      if (Object::RUBY_PLATFORM =~ /darwin/i)
        @automator = OsxAutomator.new
      else
        @automator = XautAutomator.new
      end

      @browser = Watir::Browser.new :chrome
      @browser.driver.manage.timeouts.implicit_wait = 10

      begin
        pos = options[:position].split(',')
        @browser.driver.manage.window.move_to(pos[0].to_i, pos[1].to_i)
      rescue Exception => e
        puts "Invalid position string"
      end
      begin
        size = options[:size].split(',')
        @browser.driver.manage.window.resize_to(size[0].to_i, size[1].to_i)
      rescue Exception => e
        puts "Invalid size string"
      end

      @browser.execute_script <<-JS
        document.write('Showtime! Click into window to begin.');
        document.onclick = function(e){
          window.activated = true;
          window.cursorX = e.pageX;
          window.cursorY = e.pageY;
          document.write('<br>Go!');
        }
      JS

      activated = false
      while !activated
        activated = @browser.execute_script <<-JS
          return window.activated === true;
        JS
        sleep 0.1
      end

      posBrowser = @browser.execute_script <<-JS
        return [window.cursorX, window.cursorY];
      JS
      posGlobal = @automator.mouse_location
      @offsets = {
        :x => posGlobal[0].to_i - posBrowser[0].to_i,
        :y => posGlobal[1].to_i - posBrowser[1].to_i
      }
    end

    def goto(location)
      @browser.goto location
    end

    def moveMouse (x, y)
      res = @browser.execute_script <<-JS
        return {
          scrollTop: $(window).scrollTop(),
          scrollLeft: $(window).scrollLeft(),
        }
      JS
      x += @offsets[:x] - res['scrollLeft'].to_i
      y += @offsets[:y] - res['scrollTop'].to_i
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
      options[:horizontal_percent] ||= 0.5
      size = el.wd.size
      centre = [lefttop[0] + size[0] * options[:horizontal_percent], lefttop[1] + size[1] / 2]
      moveMouse(centre[0], centre[1])

      if options[:click]
        click
      end
    end

    def type(string)
      @automator.type(string)
    end

    def click
      @automator.click
    end

    def scroll_to(selector)
      el = @browser.element :css => selector
      moveToEl(el)
    end

    def click_link(text)
      el = @browser.link :text => text
      moveToEl(el)
      click
    end

    def click_labels_input(input_name)
      el = @browser.label(:for => input_name).input
      moveToEl(el)
      click
    end

    def enter_into_input(input_name, text)
      el = @browser.input :name => input_name
      moveToEl(el, :horizontal_percent => 0.1)
      sleep 0.5
      click
      sleep 0.5
      type(text)
    end

    def select_dropdown(input_name, option)
      el = @browser.select_list :name => input_name
      moveToEl(el)
      sleep 0.5
      el.select option
    end

    def submit_form
      el = @browser.input :type => 'submit'
      moveToEl(el)
      sleep 0.5
      click
    end
  end

  class BaseAutomator
    def mouse_location
    end

    def mouse_move (x, y)
    end
  end

  class OsxAutomator < BaseAutomator
    def bin_path
      "#{File.expand_path('../../..', __FILE__)}/bin/osxautomation"
    end

    def mouse_location
      `#{bin_path} mouselocation`.split
    end

    def mouse_move (x, y)
      system( "#{bin_path} \"mousemove #{x.round} #{y.round}\" > /dev/null" )
    end

    def click
      system( "#{bin_path} \"mouseclick 1\" > /dev/null" )
    end

    def type (text)
      system( "#{bin_path} \"type #{text}\" > /dev/null" )
    end
  end

  class XautAutomator < BaseAutomator
    def mouse_location
      `python -c 'import xaut; mouse = xaut.mouse(); print "%i %i" % (mouse.x(), mouse.y())'`.split
    end

    def mouse_move (x, y)
      system( "python -c 'import xaut; mouse = xaut.mouse(); mouse.move_delay(700); mouse.move(#{x.round}, #{y.round})'" )
    end
  end
end
