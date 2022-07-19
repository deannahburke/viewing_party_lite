require 'rails_helper'

RSpec.describe 'the landing page', type: :feature do
  it 'displays name of the app' do
    visit '/'

    expect(page).to have_content("Viewing Party Lite")
  end

  it 'has button to create new user' do
    visit '/'

    expect(page).to have_button("Create New User")
    click_button("Create New User")
    expect(page).to have_current_path("/register")
  end

  #previous version functionality
  # it 'has list of existing users' do
  #   user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")
  #   user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: "db123")
  #
  #   visit '/'
  #   expect(page).to have_content("Existing Users")
  #     within "#user-0" do
  #       expect(page).to have_content("Sai")
  #       expect(page).to_not have_content("Deannah")
  #     end
  #
  #     within "#user-1" do
  #       expect(page).to have_content("Deannah")
  #       expect(page).to_not have_content("Sai")
  #     end
  #   end

  #previous version functionality
  # it 'each existing user links to user dashboard' do
  #   user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")
  #   user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: "db123")
  #
  #   visit '/'
  #   click_link("Sai's Dashboard")
  #   expect(current_path).to eq("/users/dashboard")
  #   expect(current_path).to_not eq("/users/#{user2.id}")
  # end

  it 'does not display user information to a visitor' do
    visit "/"

    expect(page).to have_content("Log In")
    expect(page).to have_button("Create New User")
    expect(page).to_not have_content("Existing Users")
  end

  it 'has a link for existing user to login' do

    visit '/'

    click_link("Log In")

    expect(current_path).to eq('/login')
  end

  it 'user can login with proper credentials' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")

    visit '/login'

    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'haisall123'
    click_button("Log In")

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Welcome, Sai!")
  end

  it 'will flash error if user credentials are bad(password)' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")

    visit '/login'

    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'shaisall12r'
    click_button("Log In")

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad")
  end

  it 'will flash error if user credentials are bad(email)' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")

    visit '/login'

    fill_in :email, with: 'SiLent@overlord.com'
    fill_in :password, with: 'haisall123'
    click_button("Log In")

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad")
  end

  it "does not show link to log in or create account if user is logged in" do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit "/"

    expect(page).to have_content("Log Out")
    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Create New User")
  end

  it "can log the user out" do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")

    visit '/login'

    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'haisall123'
    click_button("Log In")

    visit("/")

    click_link("Log Out")

    expect(current_path).to eq("/")
    expect(page).to have_content("Log In")
    expect(page).to have_button("Create New User")
  end

  it 'a registered user can view existing users emails' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: "haisall123")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: "db123")
    user2 = User.create!(name: 'Casey', email: 'casey@donuts.com', password: "cf123")

    visit '/'

    expect(page).to have_content('DMB@donuts.com')
    expect(page).to have_content('casey@donuts.com')
  end

  it 'a visitor cannot visit a dashboard' do
    visit "/dashboard"
    
    expect(current_path).to eq('/')
    expect(page).to have_content("You must be logged in or registered to access dashboard")
  end
end
