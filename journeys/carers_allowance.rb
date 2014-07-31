class CarersAllowanceJourney < BaseJourney

  def run
    goToAndCheckJQuery "#{@domain}/performance/carers-allowance"
    sleep 5

    sections = ['transactions-per-year',
                  'volumetrics',
                'user-satisfaction']

    sections.each do |id|
      scrollToEl(@browser.element(:id => id))
      sleep 4
    end

    moveToEl(@browser.link(:text => "User satisfaction"), { :click => true })
    sleep 5

    d = @browser.element(:class => "y-axis")
    moveToEl(d, { :vertical => 0.5, :horizontal => 3.0 })
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  6.0})
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  9.0})
    sleep 2
    moveToEl(d, { :vertical => 0.5, :horizontal =>  12.0})
    sleep 4

    scrollToEl(@browser.element(:class => "floated-header"))
    sleep 4

    moveToEl(@browser.link(:text => "Very satisfied"), { :click => true })
    sleep 4

    moveToEl(@browser.link(:text => "Very satisfied"), { :click => true })
    sleep 4

    moveToEl(@browser.link(:text => "Carer's Allowance applications"), { :click => true })
    sleep 5

    scrollToEl(@browser.element(:id => "users-at-each-step"))
    sleep 4
  end

end
