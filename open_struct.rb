# Aufgabe a09
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr
# 1.2
require_relative 'person_struct'
require 'date'

persons_file = 'persons.txt'
invalids_file = 'invalids.txt'
musts = %w[first_name last_name]

persons = []
invalids = []

unless File.zero?(persons_file)
  file = File.open(persons_file, 'r')
  loop do
    person_attr = {}
    file.each do |line|
      break if line.strip == '###'
      next unless line.include?(':')

      attr = line.split(':')
      attr.each(&:strip!)
      person_attr[attr[0].downcase.gsub(/[ ]/, '_')] = attr[1]
    end
    remains = musts - person_attr.keys
    remains.empty? ? persons << PersonStruct.new(person_attr) : invalids << PersonStruct.new(person_attr)
    break if file.eof?
  end
end

unless invalids.empty?
  File.exist?(invalids_file) ? File.truncate(invalids_file, 0) : nil
  file = File.open(invalids_file, 'a')
  file.write"You may want to rework the following #{invalids.length} entries.\n"
  invalids.each do |entry|
    entry.to_h.each_pair do |k, v|
      file.write"#{k}: #{v}\n"
    end
    file.write"###\n"
  end
end







# persons.each do |person|
#   #puts "Name:  #{person}"
#   #puts "Daten: #{person.list_attributes}"
# end
#
# puts "\n==========================\n\n"

persons.each { |person| puts person.list_with_name }

puts "\n==========================\n\n"

p1 = PersonStruct.new(first_name: 'Peter', last_name: 'Mueller-Luedenscheid', Fuehrerschein: 'nope')
p1.email = 'oh_noes@qq.in'
p1.lieblings_instrument = 'Oboe'

# p2_no_names = PersonStruct.new(dings: 'jo')
# puts "to_s (no names): #{p2_no_names}"
#
# p3_name_only = PersonStruct.new(name: 'MyName')
# puts "to_s (1 name):   #{p3_name_only}"
#
# puts "to_s (>1 names): #{p1}"
#
# p5_empty = PersonStruct.new()
# puts "to_s (empty):    #{p5_empty}"
#
# p6_with_pet = PersonStruct.new(first_name: 'Heribert', last_name: 'Garcia', pet_name: 'Rex')
# puts "to_s (with pet): #{p6_with_pet}"
#
# puts "to_s (attr):     #{p1.list_attributes}"
#
# puts "\n==========================\n\n"

p11 = PersonStruct.new(name: 'Sibylle')
class << p11
  def handstand
    "#{to_s} macht einen Handstand."
  end
end

puts p11.handstand
puts p1.handstand
