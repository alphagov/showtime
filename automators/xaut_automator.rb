class XautAutomator < BaseAutomator

  def mouse_location
    `python -c 'import xaut; mouse = xaut.mouse(); print "%i %i" % (mouse.x(), mouse.y())'`.split
  end

  def mouse_move (x, y)
    system( "python -c 'import xaut; mouse = xaut.mouse(); mouse.move_delay(700); mouse.move(#{x.round}, #{y.round})'" )
  end
end
