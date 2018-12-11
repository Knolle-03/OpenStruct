require 'ostruct'

PERSON = 'Person'

persons = []

file = File.open('persons', 'r')
loop do
  person_attr = {}
  file.each do |line|
    break if line == '###'
    next unless line.include?(':')

    attr = line.split(':')
    attr.each(&:strip!)

  end
end





person = OpenStruct.new
person.name = 'Peter'




#
#def get_linear_hash(filename)
#  unless File.file?(filename)
#    return nil
#  end
#  file = File.open(filename)
#  hash = {}
#  file.each do|line|
#    if line.match? /[0-9]/
#      words = line.split(' ')
#      hash[words[0]] = words[1].to_f
#    end
#  end
#  file.close
#  hash
#end