require 'rails_helper'

describe 'User', :vcr do
  it 'user can sign in' do
    user = create(:user)

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
		expect(page).to have_content("Logged in as #{user.first_name} #{user.last_name}")
  end

  it 'can log out', :js do
    user = create(:user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content('SIGN IN')
  end

  it 'is shown an error when incorrect info is entered' do
    visit login_path

    fill_in'session[email]', with: "email@email.com"
    fill_in'session[password]', with: "123"

    click_on 'Log In'

    expect(page).to have_content("Looks like your email or password is invalid")
  end
end
