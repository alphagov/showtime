class TransactionsExplorerJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance'
    sleep 4

    moveToEl(@browser.link(:text => 'Transactions Explorer'), { :click => true })
    sleep 5

    moveToEl(@browser.link(:text => 'high-volume services'), { :click => true })
    sleep 8

    moveToEl(@browser.link(:text => 'Pay As You Earn (PAYE)'), { :click => true })
    sleep 6

    scrollToEl(@browser.element(:text => 'Cost per transaction'))
    sleep 4

    moveToEl(@browser.link(:text => 'Transactions Explorer'), { :click => true })
    sleep 6

    moveToEl(@browser.link(:id => 'proposition-name'), { :click => true })
  end

end
