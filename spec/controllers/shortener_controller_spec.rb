require 'spec_helper'

RSpec.describe ShortenerController, type: :controller do

  before :each do
    Shortener.clear
  end

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

  describe 'POST #do_json_shorten' do
    it 'shortens url, responds with JSON' do
      in_url = 'http://example.com'
      post :do_json_shorten, { url: in_url }

      expect( response.headers['Content-Type']).to have_content( 'application/json' )

      data = JSON.parse( response.body )
      expect( data ).to eq({
        'url' => 'http://localhost:3000/1'
      })
    end
  end

  describe 'GET #lookup' do
    it 'responds with redirect when successful' do
      url = 'http://example.com'
      id  = Shortener.create(url)

      get :lookup, { id: id.to_s }

      expect( response ).to redirect_to( url )
    end

    it 'responds with 404 when not found' do
      get :lookup, { id: '1234' }

      expect( response ).to be_not_found
    end
  end

end
