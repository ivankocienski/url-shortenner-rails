class ShortenerController < ApplicationController

  def index
  end

  def do_shorten
    if input_url_given?
      @url = input_url
      id = Shortener.create( @url )

      @short_url = "http://localhost:3000/#{id}"
    end

    render action: :index
  end

  private

  def input_url
    params[:url].to_s
  end

  def input_url_given?
    input_url.length > 0
  end

end
