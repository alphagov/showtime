require 'rubygems'
require 'watir-webdriver'

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
  LicensingJourney.new(@browser, @automator, @offsets)
]




while true
  journeys.each do |journey|
    journey.run
  end
end

@browser.quit
