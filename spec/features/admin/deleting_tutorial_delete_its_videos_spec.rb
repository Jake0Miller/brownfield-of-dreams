require 'rails_helper'

describe 'When admin deletes tutorials', :js do
  it 'deletes the tutorials videos too' do

    admin = create(:user, role: 1)
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    within(first(".admin-tutorial-card")) do
      click_on "Destroy"
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to_not have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)

    click_link "#{tutorial_2.title}"
    expect(page).to have_content(video_2.title)
  end
end
