require 'pry'
require 'open-uri'
require 'nokogiri'

require_relative './student.rb'

class Scraper

# self.scrape_index_page is a class method that scrapes the student index page 
#('./fixtures/student-site/index.html') and a returns an array of hashes in which each 
#hash represents one student
  def self.scrape_index_page(index_url)
    html = open (index_url)
    doc = Nokogiri::HTML(html)

    student_names = doc.css(".student-name")
    array_of_student_names = [ ]
    student_names.each do |name|  
    array_of_student_names << name.text
    end

    student_locations = doc.css(".student-location")
    array_of_student_locations = [ ]
    student_locations.each do |location|
    array_of_student_locations << location.text
    end
  
    student_urls = doc.css(".student-card a[href]")
    array_of_student_urls = [ ]
    student_urls.each do |profile_url|
    array_of_student_urls << profile_url["href"]
    end

    combined_array = []
    x = 0
    array_of_student_names.each do |name|
      combined_array << {:name => name, :location => array_of_student_locations[x], :profile_url => array_of_student_urls[x]}
      x = x + 1
    end
    combined_array
  end



#This method accesses each student's profile page individually. It then scrapes the 
#student's social links, profile quote, and bio and stores this into an single hash
#that represents that specific student
  def self.scrape_profile_page(profile_url)
    html = open (profile_url)
    doc = Nokogiri::HTML(html)

    student_profile_hash = { }
    
    social_links = doc.css(".social-icon-container a[href]")
      social_links.each do |link|
        if link["href"].include?("twitter")
        student_profile_hash[:twitter]= link["href"]

        elsif link["href"].include?("linkedin")
        student_profile_hash[:linkedin]= link["href"]


        elsif link["href"].include?("github")
          student_profile_hash[:github]= link["href"]

        elsif !(link["href"].include?("github")) &&
           !(link["href"].include?("linkedin")) && 
           !(link["href"].include?("twitter")) &&
           !(link["href"].include?("facebook")) &&
           !(link["href"].include?("youtube"))
          student_profile_hash[:blog]= link["href"]
        end
      end

     
      student_profile_hash[:profile_quote] = doc.css(".profile-quote").text
      student_profile_hash[:bio] = doc.css(".description-holder p").text
      student_profile_hash
    
    end

end

