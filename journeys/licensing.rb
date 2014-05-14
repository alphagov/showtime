class LicensingJourney < BaseJourney

  def run
    @browser.goto 'www.gov.uk/performance'
    sleep 5

    moveToEl(@browser.link(:text => 'Licensing'), { :click => true })
    sleep 8

    d = @browser.element(:class => "stack0")
    moveToEl(d, { :vertical => 0.5, :horizontal => 1.0 })
    sleep 5

    moveToEl(@browser.link(:text => 'Monthly'), { :click => true })
    sleep 2

    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 / 11.0 * 6.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 / 11.0 * 7.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 / 11.0 * 8.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 / 11.0 * 9.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 / 11.0 * 10.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 })
    sleep 4

    scrollToEl(@browser.element(:id => "applications-conversion-graph"))
    sleep 8

    scrollToEl(@browser.element(:id => "top5-authorities-table"))
    sleep 5

    l = @browser.link :text => 'Cornwall Council'
    moveToEl(l, { :click => true })
    sleep 8

    scrollToEl(@browser.element(:id => "applications-table"))
    sleep 8

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
