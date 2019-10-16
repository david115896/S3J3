require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

#permet de faire creer l'instance mais ne permet pas de la recuperer par le nom val_oise
#val_oise = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html").perform


Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html").perform
	
#Scrapper.show_emails

#Scrapper.new
