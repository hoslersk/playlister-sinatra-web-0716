class Song < ActiveRecord::Base

  belongs_to :artist
  has_many :song_genres
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
    #find_by_slug(params[:id])

    # self.all.detect do |song|
    #   song.slug == params_slug
    # end
  end

#   params
# => {"splat"=>[], "captures"=>["that-one-with-the-guitar"], "slug"=>"that-one-with-the-guitar"}

end
