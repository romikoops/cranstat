module HomeSteps
  attr_accessor :package1
  attr_accessor :package2
  attr_accessor :package3

  # GIVEN

  step 'there are some test packages' do
    self.package1 = create(:package)
    self.package2 = create(:package)
    self.package3 = create(:package)
  end

  # WHEN

  step 'I open home page' do
    visit '/'
  end

  # THEN

  step 'I should see the test packages' do
    expect(page).to have_content('Package List')
    expect(page).to have_content(package1.name)
    expect(page).to have_content(package2.name)
    expect(page).to have_content(package3.name)
  end

  step 'I should no see any test packages' do
    expect(page).to have_content('No data found')
  end
end

RSpec.configure { |c| c.include HomeSteps, home_steps: true }
