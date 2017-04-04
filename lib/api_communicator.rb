require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
 #make the web request
 all_characters = RestClient.get("http://www.swapi.co/api/people")
 character_hash = JSON.parse(all_characters)
 films_hash = []
 link_hash = []
   character_hash["results"].each do |category|
     if category["name"] == character
       link_hash << category["films"]
     end
   end
         # binding.pry
     link_hash = link_hash.flatten
       link_hash.each do |link|
         response = RestClient.get(link)
         film_parse = JSON.parse(response)
         films_hash << film_parse
         # binding.pry
 end
 films_hash
 # binding.pry
end


 # iterate over the character hash to find the collection of `films` for the given
 #   `character`
 # collect those film API urls, make a web request to each URL to get the info
 #  for that film
 # return value of this method should be collection of info about each film.
 #  i.e. an array of hashes in which each hash reps a given film
 # this collection will be the argument given to `parse_character_movies`
 #  and that method will do some nice presentation stuff: puts out a list
 #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
 # some iteration magic and puts out the movies in a nice list
 films_hash.map.with_index(1) do |movie, index|
  puts "#{index}. #{movie["title"]}"
 end
end


def show_character_movies(character)
 # binding.pry
 films_hash = get_character_movies_from_api(character)
 parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
