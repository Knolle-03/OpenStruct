require 'ostruct'

persons = []
file = File.open('persons.txt', 'r')
loop do
  person_attr = {}
  file.each do |line|
    break if line.strip == '###'
    next unless line.include?(':')

    attr = line.split(':')
    attr.each(&:strip!)
    person_attr[attr[0].gsub(/[ ]/, '_')] = attr[1]
  end
  persons << OpenStruct.new(person_attr)
  break if file.eof?
end
puts persons
