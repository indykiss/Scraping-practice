
require "nokogiri"
require "pry"
require 'httparty'
require 'open-uri'
require 'mechanize'
require 'json'
require 'csv'
require 'pp'

# I am a quick and dirty scraper that works to pull multiple pages and console logs the data. 
# When working with data, the data source (indeed) did not use restful routing so page 2 would just reload the 
# same reviews as page 1. So workaround is to just console log massive amounts of data, copy and paste into 
# an excel, organize, and remove duplicates. 
# The end results isn't 100% of the data, but is a very good sample size. 

# Couple next steps: trying to get this to save to CSV

    # page_num numbers depends on the URL page. This client used index of reviews as part of their URL. 
    # which is weird
    page_num = 2000
    reviews = []

  while(page_num < 500)

    agent = Mechanize.new

    url = "INSERT_URL_HERE"
    page = agent.get(url)

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

    page = agent.get("INSERT_URL_HERE#{page_num+=20}")
    
    page_num += 20 

    puts reviews
  
  end 







# ONE ATTEMPT TO DO THIS:


#  .search("div.cmp-review-container")
#     mechanized_page = page.search("div.cmp-review-container")

#      focus_links = agent.page.links_with(:href => %r{/reviews?fcountry=ALL/})

#      focus_links = agent.page.links.find{|link| link.text == '2'}

#      review_links = page.links_with(href: %r{^/reviews?fcountry=ALL&start=\w+})


#      url = HTTParty.get("INSERT_URL") 
#      doc = Nokogiri::HTML(url) 

#     agent = Mechanize.new

#     url = "INSERT_URL"
#     page = agent.get(url)


#     CSV.open("client_reviews.csv", "w+") do |csv| 
#       csv << ["reviewText", "reviewTitle", "rating", "date", "reviewerTitle"]
#     end 

    
#     page_num = 00
#     reviews = []

# two problems-- not saving to CSV and also not going past 1st page

#   while(page_num < 1000)
#     page.search("div.cmp-review-container").each do |review|

#         reviewText= review.search("span.cmp-review-text").text
#         reviewTitle = review.search("div.cmp-review-title").text
#         rating = review.search("div.cmp-ratingNumber").text
#         date = review.search("span.cmp-review-date-created").text
#         reviewerTitle = review.search("span.cmp-reviewer-job-title").text


#         reviews.push(
#             reviewTitle: reviewTitle, 
#             reviewText: reviewText, 
#             rating: rating, 
#             date: date, 
#             reviewerTitle: reviewerTitle
#         )
#     end 

#     # CSV.open("client_reviews.csv", "a+") do |csv| 
#     #   reviews.each do |review|
#     #     csv << review
#     #   end 
#     # end 

#     puts reviews

#     page = agent.get("INSERT_URL_HERE_#{page_num+=20}")

#     page_num += 20


#   end 


# I AM A WAY TO GRAB REVIEWS AND ADD THEM TO A HASH

#      reviews = review_links.map do |link|
#          review = link.click 
#            reviewText= review.search("span.cmp-review-text").text
#            reviewTitle = review.search("div.cmp-review-title").text
#            rating = review.search("div.cmp-ratingNumber").text
#            date = review.search("span.cmp-review-date-created").text
#            reviewerTitle = review.search("span.cmp-reviewer-job-title").text
#            reviews.push(
#              reviewTitle: reviewTitle, 
#              reviewText: reviewText, 
#              rating: rating, 
#              date: date, 
#              reviewerTitle: reviewerTitle
#            )
#      end 


#      puts JSON.pretty_generate(reviews)


#      doc.search("span.cmp-review-text").text
#      doc.search("div.cmp-review-title").text
#      doc.search("div.cmp-ratingNumber").text
#      doc.search("span.cmp-review-date-created").text
#      doc.search("span.cmp-reviewer-job-title").text

#      binding.pry




# I AM THE TAGS NEEDED TO GET CONTENT

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





