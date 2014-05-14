class GovUKJourney < BaseJourney

  def run()
    @browser.goto 'www.gov.uk/performance/site-activity'
    sleep 4

    scrollToEl(@browser.element(:id => 'site-traffic'))
    sleep 5

    scrollToEl(@browser.element(:id => 'device-type'))
    sleep 5
  end

end
