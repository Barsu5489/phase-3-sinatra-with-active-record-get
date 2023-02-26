class ApplicationController < Sinatra::Base

   before do
    content_type :json
  end

  get '/' do
    { message: "Hello world" }.to_json
  end
  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end
    get '/games/:id' do 
    # look up the game in the database using its ID
    # send a JSON-formatted response of the game data
        game = Game.find(params[:id])
    # send a JSON-formatted response of the game data
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
    

  end
end
