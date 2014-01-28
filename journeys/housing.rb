class HousingJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance/housing'
    sleep 4

    scrollToEl(@browser.element(:id => 'regional_hpi'))
    sleep 5
  end

end
