class HomePageJourney < BaseJourney

  def run
    goToAndCheckJQuery "#{@domain}/performance"
    sleep 5

    sections = ['service-dashboards',
                'overview-dashboards',
                'activity-dashboards',
                'transactions-explorer'
              ]

    sections.each do |id|
      scrollToEl(@browser.element(:id => id))
      sleep 4
    end
  end

end
