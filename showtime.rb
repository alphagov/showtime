require 'rubygems'
require 'watir-webdriver'
require 'trollop'

opts = Trollop::options do
  opt :pos, "Browser window position <x,y>", :type => :string
  opt :size, "Browser window size <x,y>", :type => :string
end

# check if osxautomation or xaut is installed
`osxautomation`
osxautomation_installed = $?.success?
`python check_xaut.py`
xaut_installed = $?.success?

Dir["automators/*.rb"].each {|file| require file }
if osxautomation_installed
  @automator = OsxautomationAutomator.new
elsif xaut_installed
  @automator = XautAutomator.new
else
  @automator = BaseAutomator.new
end


@browser = Watir::Browser.new :chrome
@browser.driver.manage.timeouts.implicit_wait = 10

if opts[:pos]
  begin
    pos = opts[:pos].split(',')
    @browser.driver.manage.window.move_to(pos[0].to_i, pos[1].to_i)
  rescue Exception => e
    puts "Invalid position string #{opts[:pos]}"
  end
end

if opts[:size]
  begin
    size = opts[:size].split(',')
    @browser.driver.manage.window.resize_to(size[0].to_i, size[1].to_i)
  rescue Exception => e
    puts "Invalid size string #{opts[:size]}"
  end
end



# calibrate

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


Dir["journeys/*.rb"].each {|file| require file }

journeys = [
  LicensingJourney.new(@browser, @automator, @offsets),
  TransactionsExplorerJourney.new(@browser, @automator, @offsets)
  PayLegalisationPostJourney.new(@browser, @automator, @offsets)
]



while true
  journeys.each do |journey|
    begin
      journey.run
    rescue Watir::Exception::UnknownObjectException => e
      # run failed, start next journey
    end
  end
end

@browser.quit
