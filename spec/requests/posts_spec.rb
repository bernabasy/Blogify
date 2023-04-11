require 'rails_helper'
RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    before(:example) do
      get '/users/1/posts'
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end
    it 'contains the correct text' do
      expect(response.body).to include('Here is the list of all posts for user A')
    end
  end

  describe 'GET /show' do
    before(:example) do
      get '/users/1/posts/1'
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end
    it 'contains the correct text' do
      expect(response.body).to include('Here is a post POST for user X')
    end
  end
end
