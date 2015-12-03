
module Shortener

  extend self

  def count
    url_db.size
  end

  def clear
    @next_url_id = 0
    url_db.clear
    id_db.clear
  end

  def create( url )
    next_url_id.tap do |id|
      found = id_db[url]
      return found if found

      url_db[id] = url
      id_db[url] = id
    end
  end

  def lookup(id)
    url_db[id]
  end

  private

  def url_db
    @url_db ||= {}
  end

  def id_db
    @id_db ||= {}
  end

  def next_url_id
    (@next_url_id = (@next_url_id || 0) + 1).to_s
  end
  
end
