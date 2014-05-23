class GOVUKJourney < BaseJourney

  def run
    @browser.goto "#{@domain}/performance/site-activity"
    sleep 4

    scrollToEl(@browser.element(:id => 'site-traffic'))
    sleep 5

    scrollToEl(@browser.element(:id => 'device-type'))
    sleep 5
  end

end
