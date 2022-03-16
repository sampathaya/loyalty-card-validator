# frozen_string_literal: true

class CardValidator < ActiveModel::Validator

  def validate(record)
    return record.errors.add :number, 'Invalid card number length' unless valid_length?(record)

    record.errors.add :number, 'Invalid card number format' unless valid_start?(record)
    record.errors.add :number, 'Invalid algorithm' unless valid_algorithm?(record)

    true
  end

  private

  def valid_algorithm?(record)
    (expanded_value(record).join('').chars.map(&:to_i).reduce(:+) % 10).zero?
  end

  def expanded_value(record)
    record.number.reverse.chars.each_with_object([]).with_index do |(ch, expanded), index|
      expanded.unshift(index.odd? ? (ch.to_i * 2).to_s : ch)
    end
  end

  def valid_length?(record)
    [16, 17].any?(record.number&.length)
  end

  def valid_start?(record)
    record.number.start_with?('6014')
  end
end
