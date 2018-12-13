# Aufgabe a09
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr
# 1.2
require 'ostruct'
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
      person_attr[attr[0].gsub(/[ ]/, '_')] = attr[1]
    end
    remains = musts - person_attr.keys
    remains.empty? ? persons << OpenStruct.new(person_attr) : invalids << OpenStruct.new(person_attr)
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






