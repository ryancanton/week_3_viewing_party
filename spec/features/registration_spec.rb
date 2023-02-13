require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    user1 = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'meg@test.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it 'does not create a user if password does not match password confirmation' do
    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'meg@test.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password1234'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'does not create a user if name is not filled in' do
    visit register_path
    
    fill_in :user_name, with: ''
    fill_in :user_email, with:'meg@test.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end

  it 'does not create a user if name is not filled in' do
    visit register_path
    
    fill_in :user_name, with: 'Bobby'
    fill_in :user_email, with:'meg@test.com'
    fill_in :user_password, with: ''
    fill_in :user_password_confirmation, with: ''
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password digest can't be blank and Password can't be blank")
  end
end