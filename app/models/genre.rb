class Genre < ActiveRecord::Base

  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    words_arr = self.name.split(" ")
    slug_result = words_arr.collect {|word| word.downcase}.join("-")
    slug_result
  end

  def self.find_by_slug(params_slug)
    words_arr = params_slug.split("-")
    unslug_result = words_arr.collect {|word| word.capitalize}.join(" ")
    unslug_result
    self.where("name LIKE ?", "#{unslug_result}").first
  end

end
