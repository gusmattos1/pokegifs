class PokemonsController < ApplicationController

  def show

    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    id = body["id"]
    name  = body["name"]
    type = body["types"][0]["type"]["name"]
    key = ENV['GIPHY_KEY']

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{key}&q=#{name}&rating=g")
    giphy_body = JSON.parse(res.body)
    gif_url = giphy_body["data"][0]["url"]

    render json: {
      name: name,
      id: id,
      type: type,
      giphy: gif_url,
    }

  end
end
