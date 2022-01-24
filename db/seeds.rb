require "csv"

#Some clean up
Movie.delete_all
ProductionCompany.delete_all

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
    #clear
    puts "Invalid movie #{m['original_title']}" unless movie&.valid?
  else
    puts "invalid production company #{m["production_company"]} for movie #{m["original_title"]}."
  end
end

puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} Moives."

puts "#{ProductionCompany.all.inspect}"
puts "#{Movies.all.inspect}"
