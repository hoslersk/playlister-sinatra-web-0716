class Artist < ActiveRecord::Base

  has_many :songs
  has_many :song_genres, through: :songs
  has_many :genres, through: :song_genres

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
