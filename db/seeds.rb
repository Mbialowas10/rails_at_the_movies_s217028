require "csv"

#Some clean up
Movie.delete_all
ProductionCompany.delete_all
Page.delete_all

# data for many-to-many relationship
MovieGenre.delete_all
Genre.delete_all

filename = Rails.root.join("db/top_movies.csv") # build out the absolute path to file
puts "Loading Movie the CSV file: #{filename}"


csv_data = File.read(filename)
movies = CSV.parse(csv_data, headers:true, encoding: "utf-8")

movies.each do |m|
  # puts m["original_title"]
  # production_company = ProductionCompany.create(name: m["production_company"]) # creates an issue with production_companies not being unique
  # fix by way find_or_create__by
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])


  if production_company && production_company.valid?
    #create the movie
    movie = production_company.movies.create(
      title: m["original_title"],
      year:  m["year"],
      duration: m["duration"],
      description: m["description"],
      average_vote: m["avg_vote"]
    )

    # end our genre creation
    unless movie&.valid?
      puts "Invalid movie #{m['original_title']}"
      next
    end

    # create our genres in this space
    genres = m["genre"].split(",").map(&:strip) # { | collection_item | collection_item.strip }

    genres.each do |genre_name|
      genre = Genre.find_or_create_by(name: genre_name)

      MovieGenre.create(movie: movie, genre:genre)
    end
  else
    puts "invalid production company #{m["production_company"]} for movie #{m["original_title"]}."
  end
end

puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} Movies."
puts "Created #{Genre.count} Genres"
puts "Created #{MovieGenre.count} Movie Genres"

#puts "#{ProductionCompany.all.inspect}"
#puts "#{Movies.all.inspect}"

Page.create(
    title: 'About the Data',
    content: 'The data powering this lovely website was provided by IMDB Kaggle Dataset.',
    permalink: "about"
)
Page.create(
    title: 'Contact Us',
    content: 'If you like this site and want to chat about the project or the data, email me at: obviously_faker@email.com',
    permalink: "contact"
)
