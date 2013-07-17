class LicensingJourney < BaseJourney

  def run()

    @browser.goto 'gov.uk/performance'

    sleep 2

    l = @browser.link :text => 'Licensing performance'
    moveToEl(l)
    l.click

    sleep 2

    d = @browser.element(:class => "stack0")
    moveToEl(d)

    sleep 2

    th = @browser.th :text => 'Submissions last week'
    scrollToEl(th)

    sleep 2

    l = @browser.link :text => 'Westminster City Council'
    moveToEl(l, { :click => true })

    sleep 5
  end

end