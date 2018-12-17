# Aufgabe a09
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'ostruct'

# OpenStruct subclass for Persons with methods to return selected subsets of its
# attributes.
class PersonStruct < OpenStruct

  DEFAULT_NAME_IDENTIFIERS = %w[name firstname lastname middlename vorname nachname].freeze
  DEFAULT_CONTACT_IDENTIFIERS = %w[tel phone telefon telephone fax email website].freeze

  def initialize(*args)
    super(*args)
    @name_identifiers = DEFAULT_NAME_IDENTIFIERS
    @contact_identifiers = DEFAULT_CONTACT_IDENTIFIERS
  end

  def name
    select_attributes(@name_identifiers, true)
  end

  def attributes
    select_attributes(@name_identifiers, false)
  end

  def contact_information
    select_attributes(@contact_identifiers, true)
  end

  def to_s
    return "#<#{self.class}> (emtpy)" if @table.empty?

    name = select_attributes(@name_identifiers, true).values.join(' ')
    name.empty? ? "#<#{self.class}> (no names found)" : name
  end

  def list_all
    return to_s unless @table.size > 2

    complete_string = to_s << ' ('
    attributes.to_a.each { |pair| complete_string << pair.join(': ') + ', ' }
    complete_string.delete_suffix!(', ') << ')'
  end

  private

  def select_attributes(id_ary, from_ary)
    choice = from_ary ? :select : :reject
    @table.send(choice) { |key| id_ary.include?(key.to_s.downcase.delete('_')) }
  end
end
