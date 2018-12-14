# Aufgabe a09
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'ostruct'

# OpenStruct subclass for Persons with methods to return its name only or its
# attributes only.
class PersonStruct < OpenStruct

  DEFAULT_NAME_IDENTIFIERS = %w[name firstname lastname middlename vorname nachname].freeze

  def initialize(*args)
    super(*args)
    @name_identifiers = DEFAULT_NAME_IDENTIFIERS
  end

  def to_s
    return "#<#{self.class}> (emtpy)" if @table.empty?

    name_string = ''
    @table.each do |k, v|
      next unless @name_identifiers.include?(k.to_s.downcase.delete('_'))

      name_string << "#{' ' unless name_string.empty?}#{v}"
    end

    name_string.empty? ? "#<#{self.class}> (no names found)" : name_string
  end

  def list_attributes
    attributes = ''
    @table.each do |k, v|
      next if @name_identifiers.include?(k.to_s.downcase.delete('_'))

      attributes << "#{', ' unless attributes.empty?}#{k}: #{v}"
    end
    attributes
  end

  def list_with_name
    "#{to_s} #{'(' + list_attributes + ')' if @table.size > 2 }"
  end
end
