class Movie < ActiveRecord::Base
    def self.getMoviesByTitleOrder
        return Movie.order("title ASC")
    end
    
    def self.getMoviesByDateOrder
        return Movie.order("release_date ASC")
    end
    
    def self.getRatings
        ratings = Movie.pluck(:rating)
        ratingSet = Hash.new
        ratings.each do |rating| 
            if !ratingSet.include?(rating)
                ratingSet[rating] = true
            end
        end
        return ratingSet
    end
    
    def self.getMoviesByRatings(query)
        return Movie.where(rating: query)
    end
    
    def self.getMoviesByRatingsTitleOrder(query)
        return Movie.where(rating: query).order("title ASC")
    end
    
    def self.getMoviesByRatingsDateOrder(query)
        return Movie.where(rating: query).order("release_date ASC")
    end
end
