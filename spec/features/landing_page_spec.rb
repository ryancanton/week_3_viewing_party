require 'rails_helper'

RSpec.describe 'Landing Page' do
    before :each do 
        user1 = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
        user2 = User.create(name: 'Meg2', email: 'meg2@test.com', password: 'password123', password_confirmation: 'password123')
        visit '/'
    end 

    it 'has a header' do
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do 
        click_button "Create New User"
        
        expect(current_path).to eq(register_path) 
        
        visit '/'

        click_link "Home"
        expect(current_path).to eq(root_path)
    end 

    it 'lists out existing users' do 
        user1 = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
        user2 = User.create(name: 'Meg2', email: 'meg2@test.com', password: 'password123', password_confirmation: 'password123')

        expect(page).to have_content('Existing Users:')

        within('.existing-users') do 
            expect(page).to have_content(user1.email)
            expect(page).to have_content(user2.email)
        end     

    end 
end
