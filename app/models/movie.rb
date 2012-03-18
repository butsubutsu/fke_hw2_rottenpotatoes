class Movie < ActiveRecord::Base #; include Enumerable
  def self.all_ratings
    Movie.find(:all,:select=>"distinct rating").map{|m| m.rating}
    #Movie.find_all_by_rating
  end
end
