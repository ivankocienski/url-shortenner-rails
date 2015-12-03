require 'spec_helper'

describe Shortener do
  
  before :each do 
    subject.clear
  end

  context '#count' do
    it 'zero by default' do
      expect( subject.count ).to eq 0
    end

    it 'counts entries' do
      subject.create 'http://example.com/1'
      subject.create 'http://example.com/2'
      subject.create 'http://example.com/3'

      expect( subject.count ).to eq 3
    end
  end
  
  context '#clear' do
    it 'resets database' do
      subject.clear
      expect( subject.count ).to eq 0

      subject.create 'http://example.com/1'
      subject.create 'http://example.com/2'
      subject.create 'http://example.com/3'
      expect( subject.count ).to eq 3

      subject.clear
      expect( subject.count ).to eq 0
    end
  end

  context '#create' do
    it 'adds url to database' do
      subject.create 'http://example.com/1'
      expect( subject.count ).to eq 1 
    end

    it 'returns ID to url' do
      id = subject.create 'http://example.com/1'

      expect( id ).to eq 1
    end

    it 'does not create duplicates' do
      id1 = subject.create 'http://example.com/1'
      id2 = subject.create 'http://example.com/1'

      expect( subject.count ).to eq 1
      expect( id1 ).to eq id2
    end
  end

  context '#lookup' do
    it 'returns nil if not found' do
      found = subject.lookup 'http://example.com'
      expect(found).to be nil
    end

    it 'returns url given proper ID' do
      url = 'http://example.com'
      id  = subject.create url

      found = subject.lookup(id)
      expect( found ).to eq url
    end
  end


end

