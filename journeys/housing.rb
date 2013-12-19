class HousingJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance/housing'
    sleep 4

    scrollToEl(@browser.element(:id => 'regional_hpi'))
    sleep 5

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
