class KPIDashboardJourney < BaseJourney

  def run
    goToAndCheckJQuery "#{@domain}/performance"
    sleep 4

    moveToEl(@browser.link(:text => 'View all services'), { :click => true })
    sleep 4

    moveToEl(@browser.link(:text => 'Driving licences: renewals'), { :click => true })
    sleep 4

    digital_takeup = @browser.element(:id => "digital-take-up-per-quarter")

    moveToEl(digital_takeup, { :vertical => 0.45, :horizontal => 0.4 })
    sleep 3
    moveToEl(digital_takeup, { :vertical => 0.55, :horizontal => 0.6 })
    sleep 3
    moveToEl(digital_takeup, { :vertical => 0.45, :horizontal => 0.9 })
    sleep 6

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
