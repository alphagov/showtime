class GCloudJourney < BaseJourney

  def run
    goToAndCheckJQuery "#{@domain}/performance"
    sleep 5

    moveToEl(@browser.link(:text => 'G-Cloud'), { :click => true })
    sleep 10

    sections = ['cumulative-sales-by-company-size',
                'monthly-sales-by-company-size',
                'proportion-of-sales-from-small-and-medium-enterprises',
                'cumulative-spend-by-customer-type',
                'monthly-spend-by-lot']

    sections.each do |id|
      scrollToEl(@browser.element(:id => id))
      sleep 4
    end
  end

end
