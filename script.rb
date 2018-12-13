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

persons_file = 'persons.txt'
invalids_file = 'invalids.txt'



first name: Peter
last name: Panne
age: 43
address: Pannenstreet 345 Upstate Pannentown
car: hat ne Panne
e-mail : peter_panne@gmail.com
###
first name: Lisa
last name: Panne
age: 44
address: Pannenstreet 345 Upstate Pannentown
car: noe
###
first name: Hans Hermann
last name: Honk
age: 56
address: Bahnhof Str. 12 a 15890 Eisenhüttenstadt
car: JD 9RX
###
first name: Horst
last name: Kohlmann
###
first name: Dieter
age: 66
###
age:45
name: Gabi

Class version of 1.2

class PersonToObject
  def initialize(persons_file, invalids_file)
    @persons_file = persons_file
    @invalids_file = invalids_file
    @musts = %w[first_name last_name]
    @persons = []
    @invalids = []
  end

  def convert
    return nil if File.zero?(@persons_file)

    file = File.open(@persons_file, 'r')
    loop do
      person_attr = {}
      file.each do |line|
        break if line.strip == '###'
        next unless line.include?(':')

        attr = line.split(':')
        attr.each(&:strip!)
        person_attr[attr[0].gsub(/[ ]/, '_')] = attr[1]
      end
      remains = @musts - person_attr.keys
      remains.empty? ? @persons << OpenStruct.new(person_attr) : @invalids << OpenStruct.new(person_attr)
      break if file.eof?
    end
  end

  def rewrite
    return nil if @invalids.empty?

    File.truncate(@invalids_file, 0)
    file = File.open(@invalids_file, 'a')
    file.write"You may want to rework the following #{@invalids.length} entries.\n"
    @invalids.each do |entry|
      entry.to_h.each_pair do |k, v|
        file.write"#{k}: #{v}\n"
      end
      file.write"###\n"
    end
  end
end




