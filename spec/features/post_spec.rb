require 'rails_helper'

describe 'navigate' do
    before do
        user = User.create(email: "test@test.com", password: "123123", password_confirmation: "123123", first_name: "Raphael", last_name: "Müller")
        login_as(user, :scope => :user)
        visit new_post_path
    end
    
    describe 'index' do
        before do
            visit posts_path
        end

        it 'can be reached succesfully' do
            expect(page.status_code).to eq(200)
        end

        it 'has a title of Posts' do
            expect(page).to have_content(/Posts/)
        end

        it "has a list of posts" do
            post1 = Post.create!(date: Date.today, rationale: "Rationale 1")
            post2 = Post.create!(date: Date.today, rationale: "Rationale 2")

            visit posts_path

            expect(page).to have_content(/Rationale 1|Rationale 2/)
        end
    end

    describe 'creation' do   
        before do
            visit new_post_path
        end

        it 'has a new form that can be reached' do
            expect(page.status_code).to eq(200)
        end

        it "can be created from new form page" do
            fill_in 'post[date]', with: Date.today
            fill_in 'post[rationale]', with: "Some rationale"
            click_on "Save"
            
            expect(page).to have_content("Some rationale")
        end

        it "will have a user associated with it" do 
            fill_in 'post[date]', with: Date.today
            fill_in 'post[rationale]', with: "Some rationale"
            click_on "Save"

            expect(User.last.posts.last.rationale).to eq("Some rationale")
        end
    end
end