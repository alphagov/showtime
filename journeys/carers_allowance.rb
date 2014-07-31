class CarersAllowanceJourney < BaseJourney

  def run
    goToAndCheckJQuery "#{@domain}/performance/carers-allowance"
    sleep 5

    sections = ['transactions-per-year',
                'volumetrics',
                'user-satisfaction',
                'service-availability']

    sections.each do |id|
      scrollToEl(@browser.element(:id => id))
      sleep 4
    end
  end

end
