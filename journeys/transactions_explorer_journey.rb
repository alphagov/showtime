class TransactionsExplorerJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance'
    sleep 5

    moveToEl(@browser.link(:text => 'Transactions Explorer'), { :click => true })
    sleep 10

    moveToEl(@browser.link(:text => 'Services'), { :click => true })
    sleep 4

    bubble = @browser.element(:id => 'bubble')
    scrollToEl(bubble)
    sleep 2

    pos = getPositionOnEl(bubble, { :horizontal => 0.45, :vertical => 0.55 })
    moveToEl(bubble, { :horizontal => 0.45, :vertical => 0.55 })
    sleep 4
    showClick(pos[0], pos[1])
    @browser.link(:text => 'HM Revenue and Customs').click
    sleep 10

    bubble = @browser.element(:id => 'bubble')
    pos = getPositionOnEl(bubble, { :horizontal => 0.35, :vertical => 0.15 })
    moveToEl(bubble, { :horizontal => 0.35, :vertical => 0.15 })
    sleep 4
    showClick(pos[0], pos[1])
    @browser.link(:text => 'Pay As You Earn (PAYE)').click
    sleep 10

    moveToEl(@browser.element(:text => 'High-volume services'), { :click => true })
    sleep 10

    moveToEl(@browser.element(:text => 'Stamp Duty Reserve Tax (SDRT)'), {
      :horizontal => 0.2, :click => true
    })
    sleep 10

    @browser.goto 'gov.uk/performance'
  end

end
