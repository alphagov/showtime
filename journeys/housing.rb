class HousingJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance/housing'
    sleep 4

    scrollToEl(@browser.element(:id => 'house-price-index'))
    sleep 5
  end

end
