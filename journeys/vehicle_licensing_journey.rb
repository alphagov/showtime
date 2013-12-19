class VehicleLicensingJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance'
    sleep 5

    moveToEl(@browser.link(:text => 'Vehicle licensing'), { :click => true })
    sleep 8

    moveToEl(@browser.link(:text => 'SORN'), { :click => true })
    sleep 8

    scrollToEl(@browser.element(:id => 'sorn-failures'))
    sleep 7

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
