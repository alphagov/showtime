# Showtime

Showtime uses Selenium WebDriver with `osxautomation` (Mac OS X) or `xaut`
(Linux) to show a journey through a website. It's fantastic for showing a tour
of your site on a big monitor.

<img src="http://i.imgur.com/oyRLEgn.gif" style="width: 420px;" alt="A tour of www.gov.uk/performance" />

## Installation

For all platforms you need to
[download ChromeDriver](https://code.google.com/p/chromedriver/downloads/list)
and make sure it's on your PATH.

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

### Ubuntu

 - Install Chromium, easiest from the Ubuntu Software Center
 - Ensure rubygems is up-to-date: `sudo apt-get install rubygems`
 - `bundle install`
 - [Download xaut](http://sourceforge.net/projects/xautomation/) and extract it:

```sh
cd <xaut_directory>
./configure
make
cd python
sudo python setup.py install
```

## Running journeys

Run the journeys with `ruby showtime.rb`. Chrome will launch and prompt you to
start the journey.
