# Showtime

Webdriver + osxautomation / xaut mashup

## Installation and usage

### OS X

 - Install osxautomation:
```sh
git clone https://github.com/abersager/osxautomation
cd osxautomation
git submodule update --init
scripts/buildrun
sudo cp build/Release/osxautomation /usr/local/bin
```

 - `bundle install`
 
 - Download chromedriver

### Ubuntu
 - Install Chromium, easiest from the Ubuntu Software Center
 - Install Chromedriver:
   - Download from https://code.google.com/p/chromedriver/downloads/list
   - Unzip and put chromedriver into PATH
 - Ensure rubygems is up-to-date: `sudo apt-get install rubygems`
 - `sudo gem install watir-webdriver`
 - Install xaut:
   - Download xaut from http://sourceforge.net/projects/xautomation/
   - Extract it:
   
```sh
cd <xaut_directory>
./configure
make
cd python
sudo python setup.py install
```

### Running journeys
- `ruby showtime.rb`
