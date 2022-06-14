class Movie < ActiveRecord::Base

  # PART 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


  
  # Class method all_ratings: returns all unique entries found
  # in the rating column of the Movies model
  def self.all_ratings
    self.select(:rating).map(&:rating).uniq
    # Model.select('DISTINCT rating')
  end
  


  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    # movies with those ratings
    # if ratings_list is nil, retrieve ALL movies

    if ratings_list.empty?
      # If ratings to show is empty, show ALL movies
      movies = self.all

    else
      # Else, show the selected only
      movies = self.where(rating: ratings_list)
    end

    return movies
  end

  # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

end
