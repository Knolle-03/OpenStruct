# Aufgabe a09_2
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

# Class description
class StudiProf
  Person = Struct.new(:first_name, :last_name) do
    def to_s
      first_name.to_s + ' ' + last_name.to_s
    end
  end

  def initialize
    @persons = []
    @format = '%25.25s < %50.50s < %18.18s < %11.11s < %11.11s'
  end

  def add_person(first_name, last_name)
    @persons << Person.new(first_name, last_name)
  end

  def professionalize!
    @persons.each_with_index do |person, i|
      i.odd? ? turn_to_prof(person) : turn_to_student(person)
    end
  end

  def show_singleton_class
    puts format(@format, 'object', '.singleton_class', '.superclass', '.superclass', '.superclass')
    @persons.each do |p|
      puts format(
        @format,
        p.to_s,
        p.singleton_class,
        p.singleton_class.superclass,
        p.singleton_class.superclass.superclass,
        p.singleton_class.superclass.superclass.superclass
      )
    end
  end

  def show_singleton_methods
    @persons.each do |p|
      if p.singleton_methods.empty?
        puts "#{p} has no singleton methods."
        next
      end

      puts "#{p} has these methods: #{p.singleton_methods.join(', ')}"
    end
  end

  def execute_singleton_methods
    @persons.each do |person|
      person.singleton_methods.each { |method| person.send(method) }
    end
  end

  private

  def turn_to_prof(person)
    class << person
      def to_s
        '(Professor) ' + super
      end

      def hold_lecture(course = 'Butterflies 101')
        puts "#{self} talks about the vast field of #{course}."
      end
    end
  end

  def turn_to_student(person)
    def person.to_s
      '(Student) ' + super
    end

    def person.visit_course(course = 'Butterflies 101')
      puts "#{self} now visits #{course}."
    end

    def person.procrastinate
      puts "#{self} sleeps in today. Also, 'The dog ate my homework'."
    end
  end
end

people = StudiProf.new
defaults = [%w[Sepp Sauerbier], %w[Renate Rudolfson], %w[Trevor Tsipras], %w[Achim Ahrens], %w[Berthold Brecht], %w[Cesar Cerveza]]
defaults.each { |person| people.add_person(person[0], person[1]) }

puts "\n===== normal persons - methods: ====================================="
people.show_singleton_methods
puts "\n===== normal persons - classes: ====================================="
people.show_singleton_class
puts "\n===== normal persons - execute: ====================================="
people.execute_singleton_methods
puts "\n##### Everyone picks a role... ###################"
people.professionalize!
puts "\n===== students/profs - methods: ====================================="
people.show_singleton_methods
puts "\n===== normal persons - classes: ====================================="
people.show_singleton_class
puts "\n===== students/profs - execute: ====================================="
people.execute_singleton_methods


