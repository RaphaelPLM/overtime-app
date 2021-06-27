require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      user = User.create(email: "test@test.com", password: "123123", password_confirmation: "123123", first_name: "Raphael", last_name: "Müller")
      login_as(user, :scope => :user)
      
      @post = Post.create(date: Date.today, rationale: "This is a rationale.", user_id: user.id)
    end
    
    it "can be created" do
      expect(@post).to be_valid
    end
  
    it "cannot be created without date and rationale" do
      @post.rationale = nil
      
      expect(@post).to_not be_valid
    end
  end
end
