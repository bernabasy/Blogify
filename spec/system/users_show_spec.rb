require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User show page' do
    before(:each) do
      @user = User.create(name: 'John Doe',
                          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'I am a Full Stack Developer',
                          posts_counter: 4)

      Post.create(author: @user, title: 'My first post', text: 'This is my first post')
      Post.create(author: @user, title: 'My second post', text: 'This is my second post')
      Post.create(author: @user, title: 'My third post', text: 'This is my third post')
      Post.create(author: @user, title: 'My fourth post', text: 'This is my fourth post')

      visit user_path(@user.id)
    end

    it "can display the user's profile picture" do
      expect(page.body).to include(@user.photo)
    end

    it 'can display the user name' do
      expect(page).to have_content(@user.name)
    end

    it 'can display the user bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'can display the number of posts the user has written' do
      expect(page).to have_content(@user.posts_counter)
    end

    it "I can see a button that lets me view all of a user's posts" do
      expect(page).to have_link('See all posts')
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
