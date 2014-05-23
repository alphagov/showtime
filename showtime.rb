require 'rubygems'
require 'watir-webdriver'
require 'trollop'

opts = Trollop::options do
  opt :pos, "Browser window position <x,y>", :type => :string
  opt :size, "Browser window size <x,y>", :type => :string
  opt :browser, "Browser type", :type => :string, :default => 'chrome'
  opt :domain, "Domain name to browse to", :type => :string, :default => 'www.gov.uk'
end

@domain = opts[:domain].to_s

# Check if either osxautomation or xaut is installed

osxautomation_installed = false
begin
  `osxautomation`
  osxautomation_installed = true
rescue
end
`python check_xaut.py`
xaut_installed = $?.success?

# Set up the correct automator based on which automation software
# is installed. Prefer osxautomation over xaut if there's a choice.

Dir["./automators/*.rb"].each {|file| require file }
if osxautomation_installed
  @automator = OsxautomationAutomator.new
elsif xaut_installed
  @automator = XautAutomator.new
else
  @automator = BaseAutomator.new
end


@browser = Watir::Browser.new opts[:browser].to_s
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

# Calibrate

url = "file://#{File.expand_path(File.dirname(__FILE__))}/calibrate.html"
@browser.goto url

# auto-calibrate when possible
if opts[:pos] and opts[:size]
  activated = false
  size = opts[:size].split(',')
  pos = opts[:pos].split(',')
  centre_x = pos[0].to_i + size[0].to_i / 2.0
  centre_y = pos[1].to_i + size[1].to_i / 2.0
  @automator.mouse_move(centre_x, centre_y)

  (1..15).each do
    sleep 0.5
    @automator.mouse_click
    activated = @browser.execute_script <<-JS
      return window.activated === true;
    JS
    if activated
      break
    end
  end
  if not activated
    @browser.quit
    throw "Could not calibrate"
  end
else
  activated = false
  while !activated
    activated = @browser.execute_script <<-JS
      return window.activated === true;
    JS
    sleep 0.3
  end
end






posBrowser = @browser.execute_script <<-JS
  return [window.cursorX, window.cursorY];
JS
posGlobal = @automator.mouse_location
@offsets = {
  :x => posGlobal[0].to_i - posBrowser[0].to_i,
  :y => posGlobal[1].to_i - posBrowser[1].to_i
}

Dir["./journeys/*.rb"].each {|file| require file }
journeys = [
  VehicleLicensingJourney.new(@browser, @automator, @offsets, @domain),
  KPIDashboardJourney.new(@browser, @automator, @offsets, @domain),
  GOVUKJourney.new(@browser, @automator, @offsets, @domain),
  GCloudJourney.new(@browser, @automator, @offsets, @domain),
  LicensingJourney.new(@browser, @automator, @offsets, @domain),
]



begin
  while true
    journeys.each do |journey|
      journey.run
    end
  end
ensure
  @browser.quit
end
