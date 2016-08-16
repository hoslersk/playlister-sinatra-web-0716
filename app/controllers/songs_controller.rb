class SongsController < ApplicationController

  get '/songs' do
    @all_songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    @message = params[:message]
    #@artist = Artist.find(@song.artist_id)
    #@song
    #=> #<Song:0x007f804b241c60 id: 1, name: "That One with the Guitar", artist_id: 1>
    #binding.pry
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(params[:artist])
    #binding.pry
    if !params[:genre].empty?
      @song.genres << Genre.create(params[:genre])
    end
    @song.genres << Genre.find(params[:genre_ids])
    @song.save
    @message = "Successfully created song."
    redirect "/songs/#{@song.slug}?message=#{@message}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
     @song = Song.find_by_slug(params[:slug])
     @song.artist.update(params[:artist])
     if !params[:genre].empty?
       @song.genres << Genre.create(params[:genre])
     end
     if !params[:genre_ids].empty?
       @song.genres << Genre.find(params[:genre_ids])
     end
     @song.save
     @message = "Successfully updated song."
     redirect "songs/#{@song.slug}?message=#{@message}"
  end


end
