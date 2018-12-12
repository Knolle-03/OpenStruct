require 'ostruct'
require 'date'

# 1.1

person = OpenStruct.new
class << person
  def age_calc(day_of_birth)
    now = Time.now.utc.to_date
    now.year - day_of_birth.year - (now.month > day_of_birth.month || now.month == day_of_birth.month && now.day >= day_of_birth.day ? 0 : 1)
  end
end

person.first_name = 'Lars'
person.last_name = 'Peters'
person.birthday = Date.new(1991, 12, 12)
person.e_mail = 'lars_peters@gmail.com'
person.age = person.age_calc(person.birthday)


# 1.2
musts = %w[first_name last_name]
persons = []
invalids = []
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
  remains = musts - person_attr.keys
  remains.empty? ? persons << OpenStruct.new(person_attr) : invalids << OpenStruct.new(person_attr)
  break if file.eof?
end


puts persons
puts '---------------------'
unless invalids.empty?
  file = File.open('invalids.txt', 'a')
  file.write"You may want to rework the following #{invalids.length} entries.\n"
  invalids.each do |entry|
    entry.to_h.each_pair do |k, v|
      file.write("#{k}: #{v}\n")
    end
    file.write("###\n")
  end
end






