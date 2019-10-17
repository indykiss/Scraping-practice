
require "nokogiri"
require "pry"
require 'httparty'
require 'open-uri'
require 'mechanize'
require 'json'
require 'csv'
require 'pp'


# I get all the reviews across multiple pages! Not pretty, but I get it


# .search("div.cmp-review-container")
    # mechanized_page = page.search("div.cmp-review-container")

    # focus_links = agent.page.links_with(:href => %r{/reviews?fcountry=ALL/})

    # focus_links = agent.page.links.find{|link| link.text == '2'}

    # review_links = page.links_with(href: %r{^/reviews?fcountry=ALL&start=\w+})


    # url = HTTParty.get("https://www.indeed.com/cmp/CVS-Health/reviews") 
    # doc = Nokogiri::HTML(url) 

    agent = Mechanize.new

    url = "https://www.indeed.com/cmp/CVS-Health/reviews?fcountry=ALL&start=00"
    page = agent.get(url)


    CSV.open("cvs_reviews.csv", "w+") do |csv| 
      csv << ["reviewText", "reviewTitle", "rating", "date", "reviewerTitle"]
    end 

    
    page_num = 00
    reviews = []

# two problems-- not saving to CSV and also not going past 1st page


  while(page_num < 1000)
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

    # CSV.open("cvs_reviews.csv", "a+") do |csv| 
    #   reviews.each do |review|
    #     csv << review
    #   end 
    # end 

    puts reviews

    page = agent.get("https://www.indeed.com/cmp/CVS-Health/reviews?fcountry=ALL&start=#{page_num+=20}")

    page_num += 20


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










# class CVSReviews 
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
#    url = HTTParty.get("https://www.indeed.com/cmp/CVS-Health/reviews") 
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


  # Nokogiri::HTML(HTTParty.get("https://www.indeed.com/cmp/CVS-Health/reviews")).search("div.cmp-review-container").map do |reviews|
  #       new_review = CVSReviews.new 
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





