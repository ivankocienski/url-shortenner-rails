require 'spec_helper'

describe 'shortener/index', type: :view do
  
  context 'input form' do
    it 'is in header div' do
      render

      expect( rendered ).to have_css( '#header #input-form form' )
    end

    it 'has right route' do
      xp = "//form[action='#{root_path}']"
      render
      expect( rendered ).to have_selector( xp )
    end

    it 'has formy bits' do
      render

      # label
      xp = '//form/label[@for="url"]'
      expect( rendered ).to have_xpath( xp, text: 'url' )

      # input field
      xp = '//form/input[@type="text" and @name="url"]'
      expect( rendered ).to have_xpath( xp )
      
      # submit button
      xp = '//form/button'
      expect( rendered ).to have_xpath( xp, text: 'shorten' )

    end

    it 'is pre-populated when @url is supplied' do
      url = 'http://example.com'
      assign :url, url
      render

      xp = "//form/input[@value='#{url}']"
      expect( rendered ).to have_xpath( xp )

    end
  end

  context 'output display' do
    it 'is hidden by default' do
      render
      expect( rendered ).not_to have_css( 'p#shortenned' )
    end

    it 'shows shortenned url when @short_url is set' do
      url = 'http://thi.ng/Ghu3j'
      assign :short_url, url
      render

      xp = "//p[@id='shortenned']/a[@href='#{url}']"
      expect( rendered ).to have_xpath( xp, text: url )
    end
  end

end
