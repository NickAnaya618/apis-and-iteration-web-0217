require 'rest-client'
require 'json'
require 'pry'
# iterate over the character hash to find the collection of `films` for the given
#   `character`
# && character == character_hash["results"][index]["name"].downcase

def get_character_movies_from_api(character)
  #make the web request
  i = 1
  final_array = []
  while i < 10
      all_characters = RestClient.get('http://www.swapi.co/api/people/' + "?page=#{i}")
      character_hash = JSON.parse(all_characters)
      final_array << character_hash["results"]
    i += 1
  end

  final_array = final_array.flatten

  film_collection = []

  final_array.each_with_index do |char_hash, index|
    if character == final_array[index]["name"].downcase
      film_collection << final_array[index]["films"]
    end
  end

  film_collection = film_collection.flatten

  film_collection.collect do |film_url|
      all_films = RestClient.get(film_url)
      films_hash = JSON.parse(all_films)
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |movie_hash, index|
    puts films_hash[index]["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
