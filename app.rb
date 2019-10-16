require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

val_oise = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html")
val_oise.perform

puts val_oise.show_emails
