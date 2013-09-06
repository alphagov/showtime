# Showtime

Webdriver + osxautomation / xaut mashup

## Install

Install Chromedriver:

- Download from https://code.google.com/p/chromedriver/downloads/list
- Unzip and put chromedriver into PATH

## Usage

    require 'showtime'

    Showtime::Journey.new({ :size => "960,600" :position => "0,0"}) do
      goto 'google.com'
      sleep 2
      enter_into_input('q', 'Let me google that for you')
      sleep 1
      submit_form
      sleep 5
    end

