class VehicleLicensingJourney < BaseJourney

  def run
    goToAndCheckJQuery "#{@domain}/performance"
    sleep 5

    moveToEl(@browser.link(:text => 'Vehicle licensing'), { :click => true })
    sleep 8

    moveToEl(@browser.link(:text => 'Tax disc'), { :click => true })
    sleep 8

    scrollToEl(@browser.element(:id => 'recorded-errors'))
    sleep 7

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
