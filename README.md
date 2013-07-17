# Showtime

Webdriver + osxautomation / xaut mashup

## Installation and usage

### OS X

 - Install osxautomation: ```bash
git clone https://github.com/joseph/osxautomation
cd osxautomation
scripts/buildrun
sudo cp build/Release/osxautomation /usr/local/bin
```

 - `sudo gem install watir-webdriver`
 
### Ubuntu
 - Install Chromium, easiest from the Ubuntu Software Center
 - Install Chromedriver:
   - Download from https://code.google.com/p/chromedriver/downloads/list
   - Unzip and put chromedriver into PATH
 - Ensure rubygems is up-to-date: `sudo apt-get install rubygems`
 - `sudo gem install watir-webdriver`
 - Install xaut:
   - Download xaut from http://sourceforge.net/projects/xautomation/
   - Extract it
   - ```bash
cd <xaut_directory>
./configure
make
cd python
sudo python setup.py install
```

### Running journeys
- `ruby showtime.rb`
