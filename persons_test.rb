# Aufgabe a09
# Team ChillyCrabs | NeamTame
# Author:: Lennart Draeger
# Author:: Robert Gnehr

require 'test/unit'
require_relative 'person_struct'

# Unit test for PersonStruct.
class MyTest < Test::Unit::TestCase
  def setup
    @attributes = %i[first_name last_name website fax mobile]
  end

  def test_incomplete_information
    assert_nothing_raised { PersonStruct.new }
    assert_nothing_raised { PersonStruct.new(first_name: 'Adelbert', last_name: 'Apfelsaft') }
    assert_nothing_raised { PersonStruct.new(website: 'www.nothing-here.com', fax: '09823735365') }
  end

  def test_person_with_full_details
    full_person = PersonStruct.new(
      first_name: 'Adelbert',
      last_name: 'Apfelsaft',
      website: 'www.nothing-here.com',
      fax: '09823735365',
      mobile: '4567890987'
    )
    @attributes.each { |attr| assert_true(full_person.respond_to?(attr)) }
  end

  def test_empty_person
    empty_person = PersonStruct.new
    @attributes.each { |attr| assert_false(empty_person.respond_to?(attr)) }
  end

  def test_add_attribute
    empty_person = PersonStruct.new
    assert_false(empty_person.respond_to?(:special_attribute))
    empty_person.special_attribute = 'anything'
    assert_true(empty_person.respond_to?(:special_attribute))
  end
end
