class GCloudJourney < BaseJourney

  def run()
    @browser.goto 'gov.uk/performance'
    sleep 5

    moveToEl(@browser.link(:text => 'G-Cloud'), { :click => true })
    sleep 10

    sections = ['monthly-procurement-by-company-size',
                'proportion-of-procurement-from-small-and-medium-enterprises',
                'cumulative-spend-by-customer-type',
                'monthly-spend-by-lot']

    sections.each do |id|
      scrollToEl(@browser.element(:id => id))
      sleep 5
    end
  end

end
