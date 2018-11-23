
class Scraper 
  attr_accessor :title, :descr, :index 
  @titles = []
  @descr = [] 
  @all = []

  
  def self.scraping_page
   url = HTTParty.get("https://thegreatestbooks.org/") 
   doc = Nokogiri::HTML(url)     
    
    doc.css("div.col-sm-7").collect do |book|
      #book = Book.new 
     # book << book_info
      book_info = {
        :title => book.css("h4").text.gsub(/\s+/, ' ').strip,
        :descr => book.css("div.media-body").text.strip,
      }

      puts book_info[:title] 

      #book_info[1][0]

      #I work! better but catch 22 :(
      @titles << book_info.to_a[0][1].split(/[0-9]+[' ']+["."]+/)
      
      ugly_descr = book_info.to_a[1][1].split(/\n/)
      
    
      ugly_descr.each do |item|
        if item.length > 40
          @descr << item 
        end 
      end 
      

    #@titles.zip(@descr).each do |x,y|
    #  puts x 
    #  puts y 
    #binding.pry

    #end 
  end 
end 

  def self.titles 
    return @titles 
    #binding.pry 
  end 
  
  def self.descr
    puts @descr
  end 
  
  
  def self.all 
    @@all 
  end 


  def self.answer 
    scraping_page
    input = nil 
    
    #shouldn't input = gets.strip be here?
    
    while input != "exit"
      puts "Please input the rank of the book you want and we will provide name and description. Or press exit."  
      input = gets.strip 
      i = input.to_i
        
          puts "Your selected book is: "
          puts @titles[0][i][1..-2]
          puts "Here is the beginning of the summary:"
          puts @descr[i-1]
      end 
  end 
  
end 

    # i like this but not sure if it could work 
    #@@all =@@titles.zip @@descr 
    #@@titles.zip(@@descr).each_index do |title, descr, i|
    #  puts @@titles[i]
    #  puts @@descr[i]
    #end 



# Under answer method, one of the many reasons why I don't work is because the @@titles and stuff AREN'T ARRAYS OF ARRAYS :(
     # if input.to_i == 1
      #  puts "#{@@titles[0]} is about... #{@@descr[0]}." 
       # puts "Here is the list of books available again." 
       # binding.pry 
        #puts @@titles 
        

  
# I WORKED! BUT MADE TOO MANY SEPARATE CLASS METHODS. First attempt at the loop in scraping_page
    #book_info.each do |doc| 
     # book = self.new 
    #  book.title = doc.search("h4").text.gsub(/\s+/, ' ').strip 
     # @@titles << [book.title] 
    #  book.descr = doc.search("div.media-body").text.strip
    #  @@descr << [book.descr]
    #  @@all << [book] 

  
  
=begin book1 = self.new 
this is the index of the book 
index1 = doc.search("h4")[11].text 
 this gives me the index + title + author for simplicity 
 title1 = doc.search("h4")[0].text.gsub(/\s+/, ' ').strip 
 
  this gives me the beginning part of the book description 
  descr1 = doc.search("div.media-body")[0].text.strip 
  book1 = [index1, title1, descr1] 
  

  book2 = self.new 
  index2 = doc.search("h4")[11].text 
  title2 = doc.search("h4")[1].text.gsub(/\s+/, ' ').strip 
  descr2 = doc.search("div.media-body")[1].text.strip book2 = [index2, title2, descr2] 
  book3 = self.new index3 = doc.search("h4")[11].text 
  title3 = doc.search("h4")[2].text.gsub(/\s+/, ' ').strip 
  descr3 = doc.search("div.media-body")[2].text.strip 
  book3 = [index3, title3, descr3] 
  @@all = [book1, book2, book3] 
  @@titles << title1 
  @@titles << title2 
  @@titles << title3 
  @@descr << descr1 
  @@descr << descr2 
  @@descr << descr3 
  #binding.pry end 




=end


