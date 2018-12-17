# Aufgabe a09
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require_relative 'person_struct'

# Class description
class StructReader
  def initialize
    @line_delimiter = ':'
    @object_delimiter = '###'
    @musts = %w[first_name last_name]

    @persons = []
    @invalids = []
  end

  def load_from_file(persons_file)
    raise ArgumentError, "File not found: #{persons_file}" if File.zero?(persons_file)

    File.open(persons_file, 'r') do |file|
      person_attr = []
      file.each do |line|
        if line.include?(@line_delimiter)
          person_attr << attribute_pair_from_string(line)
        elsif line.strip == @object_delimiter
          create_person(person_attr.to_h)
          person_attr = []
        end
      end
    end
    puts "#{@persons.size} persons #{"and #{@invalids.size} invalid structs" unless @invalids.nil?} found."
    @persons.dup
  end

  def invalids_to_file(invalids_file)
    return false if @invalids.empty?

    File.truncate(invalids_file, 0) if File.exist?(invalids_file)
    File.open(invalids_file, 'a') do |file|
      file.write("You may want to rework the following #{@invalids.length} entries.\n")
      @invalids.each do |entry|
        entry.to_h.each_pair { |k, v| file.write("#{k}: #{v}\n") }
        file.write(@object_delimiter + "\n")
      end
    end
  end

  def invalids_found?
    !@invalids.empty?
  end

  private

  def attribute_pair_from_string(string)
    attr = string.split(@line_delimiter, 2)
    attr.each(&:strip!)
    [attr[0].downcase.gsub(/[ ]/, '_'), attr[1]]
  end

  def create_person(attributes)
    return if attributes.empty?

    target = (@musts - attributes.keys).empty? ? @persons : @invalids
    target << PersonStruct.new(attributes)
  end
end

# Script:
sr = StructReader.new
persons = sr.load_from_file('persons.txt')
persons.each { |v| puts v.list_all }
sr.invalids_to_file('invalids.txt') if sr.invalids_found?
