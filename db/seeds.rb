# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'


path = File.expand_path("..", __FILE__)
file = open(path+'/poems-used.json').read
json = JSON.parse(file)

class Poem
  attr_accessor :title, :poem
end

poems = []
json.each do |title, poem|
  allpoem=poem.join(" ");
  Title.create(name: title)
  Str.create(titleid: Title.last.id, text: allpoem)
  
end

