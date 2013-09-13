class VehicleLicensingJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance'
    sleep 5

    moveToEl(@browser.link(:text => 'Services'), { :click => true })
    sleep 4

    moveToEl(@browser.link(:text => 'Vehicle licensing'), { :click => true })
    sleep 8

    moveToEl(@browser.link(:text => 'SORN'), { :click => true })
    sleep 8

    scrollToEl(@browser.element(:text => 'Error codes (web)'))
    sleep 7

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
