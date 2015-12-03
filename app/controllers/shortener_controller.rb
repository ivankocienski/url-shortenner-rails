class ShortenerController < ApplicationController

  before_filter :shorten_url, only: [ :do_shorten, :do_json_shorten ] 

  def index
  end

  def do_shorten
    render action: :index 
  end

  def do_json_shorten 
    render json: { url: @short_url } 
  end

  def lookup
    id = params[:id]
    url = Shortener.lookup(id)

    if url
      redirect_to url
    else
      render status: :not_found, nothing: true
    end
  end

  private

  def input_url
    params[:url].to_s
  end

  def input_url_given?
    input_url.length > 0
  end

  def shorten_url
    if input_url_given?
      @url = input_url
      id = Shortener.create( @url )

      @short_url = "http://localhost:3000/#{id}"
    end
  end

end
