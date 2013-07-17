class OsxautomationAutomator < BaseAutomator

  def mouse_location
    `osxautomation mouselocation`.split
  end

  def mouse_move (x, y)
    system( "osxautomation \"mousemove #{x.round} #{y.round}\" > /dev/null" )
  end
end
