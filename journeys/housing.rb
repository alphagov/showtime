class HousingJourney < BaseJourney

  def run()
    goToAndCheckJQuery "#{@domain}/performance/housing"
    sleep 4

    scrollToEl(@browser.element(:id => 'house-price-index'))
    sleep 5
  end

end
