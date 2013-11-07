class PayLegalisationPostJourney < BaseJourney

  def run()

    @browser.goto 'gov.uk/performance'
    sleep 5

    moveToEl(@browser.link(:text => 'Services'), { :click => true })
    sleep 4

    moveToEl(@browser.link(:text => 'Pay to get documents legalised by post'), { :click => true })
    sleep 10
    scrollToEl(@browser.element(:id => 'volumetrics-submissions'))
    moveToEl(@browser.element(:id => 'volumetrics-submissions-selected'))
    sleep 5

    d = @browser.element(:class => "stack0")
    moveToEl(d, { :vertical => 0.5, :horizontal =>  6.0 / 8.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  7.0 / 8.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  1.0 })
    sleep 10

    scrollToEl(@browser.element(:class => "uptime"))
    sleep 10

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })

  end

end