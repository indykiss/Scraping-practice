
require "nokogiri"
require "pry"
require 'httparty'
require 'open-uri'
require 'mechanize'
require 'json'
require 'csv'
require 'pp'

# This rb file is a work in progress for an attempt to scrape multiple pages
# And take this data and push it into a CSV. 
# This does not work. Do not use this UNLESS I'm ready to put in like 5 hours of work
# To get this up and running.


# I'm working through how to get pagination done. I have the code for getting one page
# scrapped beautifully and parsed well, BUT multiple pages is a struggle.
# Follow mechanize guides. You love Chris Mytton's guides. Just need to add a bit to it


# .search("div.cmp-review-container")
    # mechanized_page = page.search("div.cmp-review-container")

    # focus_links = agent.page.links_with(:href => %r{/reviews?fcountry=ALL/})

    # focus_links = agent.page.links.find{|link| link.text == '2'}

    # review_links = page.links_with(href: %r{^/reviews?fcountry=ALL&start=\w+})


    # url = HTTParty.get("INSERT_URL") 
    # doc = Nokogiri::HTML(url) 

    agent = Mechanize.new

    url = "INSERT_URL"
    page = agent.get(url)


    CSV.open("client_reviews.csv", "w+") do |csv| 
      csv << ["reviewText", "reviewTitle", "rating", "date", "reviewerTitle"]
    end 

    another_page = true 
    page_num = 00
    reviews = []



  while another_page == true 
    page.search("div.cmp-review-container").each do |review|

        reviewText= review.search("span.cmp-review-text").text
        reviewTitle = review.search("div.cmp-review-title").text
        rating = review.search("div.cmp-ratingNumber").text
        date = review.search("span.cmp-review-date-created").text
        reviewerTitle = review.search("span.cmp-reviewer-job-title").text


        reviews.push(
            reviewTitle: reviewTitle, 
            reviewText: reviewText, 
            rating: rating, 
            date: date, 
            reviewerTitle: reviewerTitle
        )

    end 


  CSV.open("client_reviews.csv", "a+") do |csv| 
    reviews.each do |review|
      csv << review
    end 
  end 

  page_num += 20

  page = agent.get("INSERT_URL#{page_num}")

  

end 


    # reviews = review_links.map do |link|
    #     review = link.click 
    #       reviewText= review.search("span.cmp-review-text").text
    #       reviewTitle = review.search("div.cmp-review-title").text
    #       rating = review.search("div.cmp-ratingNumber").text
    #       date = review.search("span.cmp-review-date-created").text
    #       reviewerTitle = review.search("span.cmp-reviewer-job-title").text
    #       reviews.push(
    #         reviewTitle: reviewTitle, 
    #         reviewText: reviewText, 
    #         rating: rating, 
    #         date: date, 
    #         reviewerTitle: reviewerTitle
    #       )
    # end 


    # puts JSON.pretty_generate(reviews)


    # doc.search("span.cmp-review-text").text
    # doc.search("div.cmp-review-title").text
    # doc.search("div.cmp-ratingNumber").text
    # doc.search("span.cmp-review-date-created").text
    # doc.search("span.cmp-reviewer-job-title").text

    # binding.pry










# class ClientReviews 
#   attr_accessor :review, :title, :date, :reviewer_title, :rating
#     @@all = []

#   def initialize(review=nil, title=nil, date=nil, reviewer_title=nil, rating=nil)
#     @review = review
#     @title = title
#     @date = date
#     @rating = rating
#     @reviewer_title = reviewer_title
#     @@all << self
#   end

#   def self.all 
#     @@all
#   end 
  
# end 


# class Scraper
#   attr_accessor :review, :title, :date, :reviewer_title, :rating

#   def self.scraping_page
#    url = HTTParty.get("INSERT_URL") 
#    doc = Nokogiri::HTML(url) 
   
#    get_page = doc.search("div.cmp-review-container")
#    binding.pry

  
#    # change me
#   get_page.each do |reviews|
#       if reviews.search("div.cmp-review").text != ""
#         new_review = CVSReviews.new 
#         new_review.review = reviews.search("span.cmp-review-text").text
#         new_review.title = reviews.search("div.cmp-review-title").text
#         new_review.rating = reviews.search("div.cmp-ratingNumber").text
#         new_review.reviewer_title = reviews.search("span.cmp-reviewer-job-title").text
#         new_review.date = reviews.search("span.cmp-review-date-created").text
#       end 
#     end

#     console.log(@@all)

#   end 

# end 


  # Nokogiri::HTML(HTTParty.get("INSERT_URL")).search("div.cmp-review-container").map do |reviews|
  #       new_review = ClientReviews.new 
  #       new_review.review = reviews.search("span.cmp-review-text").text
  #       new_review.title = reviews.search("div.cmp-review-title").text
  #       new_review.rating = reviews.search("div.cmp-ratingNumber").text
  #       new_review.date = reviews.search("span.cmp-review-date-created").text
  #       new_review.reviewer_title = reviews.search("span.cmp-reviewer-job-title").text
  #   end   


# everything -> div.cmp-content
# box with the review -> cmp-review
# rating -> div.cmp-ratingNumber
# title -> div.cmp-review-title
# reviewer_title -> span.cmp-reviewer-job-title => nested in a span
# date -> span.cmp-review-date-created 
# review -> span.cmp-review-text

# Gives me all the doc text: doc.search("div#cmp-content").text
# Gives me all the reviews: doc.search("div.cmp-review-container").text
# Gives me all the ratings: doc.search("div.cmp-ratingNumber").text
# Gives me all the dates: doc.search("span.cmp-review-date-created").text
# Gives me all the review titles: doc.search("div.cmp-review-title").text
# Gives me all the reviewer titles: doc.search("span.cmp-reviewer-job-title").text
# Gives me the content for reviews: doc.search("span.cmp-review-text").text





