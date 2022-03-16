# frozen_string_literal: true

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test 'empty card number' do
    card = Card.new(number: '')
    assert_not card.valid?, 'invalid card'
    assert_equal(card.errors.messages[:number].first, 'Invalid card number length')
  end

  test 'invalid number length with shorter length' do
    card = Card.new(number: '0000000000')
    assert_not card.valid?
    assert_equal(card.errors.messages[:number].first, 'Invalid card number length')
  end

  test 'invalid number length with larger length' do
    card = Card.new(number: '000000000000000000')
    assert_not card.valid?
    assert_equal(card.errors.messages[:number].first, 'Invalid card number length')
  end

  test 'invalid number format' do
    card = Card.new(number: '00000000000000000')
    assert_not card.valid?
    assert_equal(card.errors.messages[:number].first, 'Invalid card number format')
  end

  # checking black card number type

  test 'black card number type check with 16 digits' do
    card = Card.new(number: '6014100000000000')
    assert_equal(card.type, 'Black')
  end

  test 'black card number type check with 17 digits' do
    card = Card.new(number: '60141000000000000')
    assert_equal(card.type, 'Black')
  end

  test 'black card number type check with 15 digits' do
    card = Card.new(number: '601410000000000')
    assert_nil card.type
  end

  test 'black card number type check with 18 digits' do
    card = Card.new(number: '601410000000000000')
    assert_nil card.type
  end

  # checking red card number type

  test 'red card number type check with 16 digits' do
    card = Card.new(number: '6014352000000000')
    assert_equal(card.type, 'Red')
  end

  test 'red card number type check with 17 digits' do
    card = Card.new(number: '60143520000000000')
    assert_nil card.type
  end

  test 'red card number type check with 15 digits' do
    card = Card.new(number: '601435200000000')
    assert_nil card.type
  end

  test 'red card number type check with 18 digits' do
    card = Card.new(number: '601435200000000000')
    assert_nil card.type
  end

  # checking green card number type

  test 'correct green card number type check with 16 digits lower range' do
    card = Card.new(number: '6014355526000000')
    assert_equal(card.type, 'Green')
  end

  test 'correct green card number type check with 16 digits upper range' do
    card = Card.new(number: '6014355529000000')
    assert_equal(card.type, 'Green')
  end

  test 'incorrect green card number type check with 17 digits' do
    card = Card.new(number: '60143555260000000')
    assert_nil card.type
  end

  test 'green card number type check with 15 digits' do
    card = Card.new(number: '601435552600000')
    assert_nil card.type
  end

  test 'green card number type check with 18 digits' do
    card = Card.new(number: '601435552600000000')
    assert_nil card.type
  end
end
