class Movie < ActiveRecord::Base

  # PART 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  # Class method all_ratings: returns all unique entries found
  # in the rating column of the Movies model
  def self.all_ratings
    self.select(:rating).map(&:rating).uniq
    # Model.select('DISTINCT rating')
  end
  
  # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

end
