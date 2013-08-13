class OsxautomationAutomator < BaseAutomator

  def mouse_location
    `osxautomation mouselocation`.split
  end

  def mouse_move (x, y)
    system( "osxautomation \"mousemove #{x.round} #{y.round}\" > /dev/null" )
  end

  def mouse_click (button=1)
    system( "osxautomation \"mouseclick #{button}\" > /dev/null" )
  end
end
