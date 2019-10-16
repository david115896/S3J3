require 'nokogiri'
require 'open-uri'


class Scrapper   #une instance = un departement
	attr_accessor :url, :list_emails_array, :urls_all_cities_array
	@@all_departments = Array.new
	@@city_name = ""
	@@email_mairie = ""
	@@page = ""
	@@result_hash = Hash.new
	
	def initialize(url)
		@url = url
		@list_emails_array = Array.new
		@urls_all_cities_array = Array.new
		@@all_departments << self
	end
		
	def self.show_emails
		return @@all_departments[0].list_emails_array
	end	

	def get_html_from_url(url_to_analyze)
		return Nokogiri::HTML(open(url_to_analyze))
	end


	def get_list_of_links_cities_method_open(url_of_department)
        	cities_link_array = get_html_from_url(url_of_department).xpath('//html/body/table/tr[3]/td/table/tr/td[2]/table/tr/td')
        	cities_link_array.css("a").map{|link| @urls_all_cities_array << "http://annuaire-des-mairies.com#{link['href'][1,link['href'].length]}"}
	end 

	def perform
        	get_list_of_links_cities_method_open(@url)
		@urls_all_cities_array.each do |html_link|
	  		@@result_hash = Hash.new
			@@page = get_html_from_url(html_link)
		  	
			@@city_name = @@page.xpath('/html/body/div/main/section[2]/div/table/thead/tr/th[1]').text.capitalize
			@@email_mairie = @@page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
			
			@@result_hash[@@city_name[32,@@city_name.length]] = @@email_mairie
			
			@list_emails_array << @@result_hash
		end
	end
	
	def self.json
		File.open("db/emails.json","w") do |f|
			@all_departments[0].list_emails_array.each do |mairie|
			#puts @@all_departments[0].list_emails_array
			#f.write(@@all_departments[0].list_emails_array)
			f.write(mairie.to_json)
			end
		end

	end



end
