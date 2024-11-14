require "faker"
require 'uri'
require 'net/http'
puts "🗑️ Deleting all movies... 🗑️"
Movie.destroy_all

puts "🗑️ Deleting all lists... 🗑️"
List.destroy_all

puts "🗑️ Deleting all bookmarks... 🗑️"
Bookmark.destroy_all

puts "🎬 Creating movies... 🎬"

base_url_img = "https://image.tmdb.org/t/p/original"

10.times do
  random = (1...500).to_a.sample

  url = URI("https://api.themoviedb.org/3/discover/movie?page=#{random}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOGUzNTU3N2I2MWFhMTJmOWFiM2Q5YWZkMWVmODI5NiIsIm5iZiI6MTczMTU4MDkyMC43OTA5MzYsInN1YiI6IjY3MzVkMzk0YjA0Mjk3ZjcwYzY4MmVjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ac74GZCQXL0k8IZeyAWKOFaVWqmFBtFKEi6fM5R9Cig'

  response = http.request(request)
  data = JSON.parse(response.read_body)
  result = data['results'].sample

  title = result['title']
  overview = result['overview']
  poster_img = base_url_img + result['poster_path']

  unless Movie.exists?(title: result['title'])
    title = result['title']
    overview = result['overview']
    poster_img = base_url_img + result['poster_path']

    Movie.create(
      title: title,
      overview: overview,
      poster_url: poster_img,
      rating: Faker::Number.between(from: 0, to: 10)
    )
  end
end

puts "✅ #{Movie.count} movies created! ✅"
