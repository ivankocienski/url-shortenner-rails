require 'spec_helper'

RSpec.describe ShortenerController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #do_shorten' do
    it 'renders index with nothing set if nothing is given' do
      post :do_shorten
      expect( assigns[:url] ).to be_nil
      expect( assigns[:short_url] ).to be_nil
      expect( response ).to render_template(:index)
    end

    it 'shortens url when given' do
      in_url = 'http://example.com'
      post :do_shorten, { url: in_url }
      expect( assigns[:url] ).to eq in_url
      expect( assigns[:short_url] ).to eq 'http://localhost:3000/1'
    end
    
  end

end
