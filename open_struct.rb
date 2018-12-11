require 'ostruct'

PERSON = 'Person'

persons = []

file = File.open('persons.txt', 'r')
i = 0
loop do
  person_attr = {}
  file.each do |line|
    break if line.strip! == '###'
    next unless line.include?(':')

    attr = line.split(':')
    attr.each(&:strip!)
    person_attr[attr[0].gsub(/[ ]/, '_').to_sym] = attr[1]
  end
  persons << instance_variable_set("@Person_#{i += 1}", OpenStruct.new(person_attr))
  break if file.eof?

end




puts persons[2].class



