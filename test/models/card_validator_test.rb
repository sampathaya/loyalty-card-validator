# frozen_string_literal: true

require 'test_helper'

class CardValidatorTest < ActiveSupport::TestCase
  setup do
    @validator = CardValidator.new
  end

  test 'empty card number' do
    card = Card.new(number: '')
    assert_not @validator.send(:valid_length?, card)
  end

  test 'less digits card number length' do
    card = Card.new(number: '000000000')
    assert_not @validator.send(:valid_length?, card)
  end

  test 'more digits card number length' do
    card = Card.new(number: '0000000000000000000000000')
    assert_not @validator.send(:valid_length?, card)
  end

  test '16 digit card number length' do
    card = Card.new(number: '0000000000000000')
    assert @validator.send(:valid_length?, card)
  end

  test '17 digit card number length' do
    card = Card.new(number: '00000000000000000')
    assert @validator.send(:valid_length?, card)
  end

  test 'card number starting value check' do
    card = Card.new(number: '00000000')
    assert_not @validator.send(:valid_start?, card)
  end

  test 'valid card number starting value check' do
    card = Card.new(number: '6014')
    assert @validator.send(:valid_start?, card)
  end

  # test number algorithm

  test 'should pass the algorithm' do
    card = Card.new(number: '6014355510000028')
    assert @validator.send(:valid_algorithm?, card)
  end

  test 'should not pass the algorithm 2' do
    card = Card.new(number: '6014365510000028')
    assert_not @validator.send(:valid_algorithm?, card)
  end

  test 'should not pass the algorithm 3' do
    card = Card.new(number: '6014355510000029')
    assert_not @validator.send(:valid_algorithm?, card)
  end

  # test card numbers

  test 'test card numbers' do
    numbers = [{
      number: '60141016700078611',
      valid: true,
      type: 'Black'
    },
               {
                 number: '6014152705006141',
                 valid: false,
                 type: 'Black'
               },
               {
                 number: '6014111100033006',
                 valid: true,
                 type: 'Black'
               },
               {
                 number: '6014709045001234',
                 valid: true,
                 type: 'Blue'
               },
               {
                 number: '6014352700000140',
                 valid: true,
                 type: 'Red'
               },
               {
                 number: '6014355526000020',
                 valid: true,
                 type: 'Green'
               },
               {
                 number: '6014355526000028',
                 valid: false,
                 type: 'Green'
               },
               {
                 number: '6013111111111111',
                 valid: false,
                 type: nil
               }]

    numbers.each do |item|
      card = Card.new(number: item[:number])
      assert_equal(card.valid?, item[:valid])
      assert_equal(card.type, item[:type])
    end
  end
end
