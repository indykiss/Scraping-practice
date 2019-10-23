require "nokogiri"
require "pry"
require 'httparty'
require 'open-uri'
require 'mechanize'
require 'json'


# This scrapes all the data off a single page and parses it into a hash! Yay! 
# To get this to work, run "ruby quick-scraper.rb" from the command line, path being desktop
# Next step is to get this to work across all the pages

    url = HTTParty.get("INSERT_URL") 
    doc = Nokogiri::HTML(url) 
  

    reviews = []

    doc.search("div.cmp-review-container").each do |review| 
          reviewText= review.search("span.cmp-review-text").text
          reviewTitle = review.search("div.cmp-review-title").text
          rating = review.search("div.cmp-ratingNumber").text
          date = review.search("span.cmp-review-date-created").text
          reviewerTitle = review.search("span.cmp-reviewer-job-title").text
          reviews.push(
            reviewText: reviewText, 
            reviewTitle: reviewTitle, 
            rating: rating, 
            date: date, 
            reviewerTitle: reviewerTitle
          )
    end 


    puts JSON.pretty_generate(reviews)




# Here are the tags I pulled off the DOM to capture the right content. 

# Gives me all the doc text: doc.search("div#cmp-content").text
# Gives me all the reviews: doc.search("div.cmp-review-container").text
# Gives me all the ratings: doc.search("div.cmp-ratingNumber").text
# Gives me all the dates: doc.search("span.cmp-review-date-created").text
# Gives me all the review titles: doc.search("div.cmp-review-title").text
# Gives me all the reviewer titles: doc.search("span.cmp-reviewer-job-title").text
# Gives me the content for reviews: doc.search("span.cmp-review-text").text
