# frozen_string_literal: true

class Card < ApplicationRecord
  include ActiveModel::Validations
  validates_with CardValidator

  validates :number, presence: true

  belongs_to :customer

  def type
    if black?
      'Black'
    elsif red?
      'Red'
    elsif green?
      'Green'
    elsif blue?
      'Blue'
    end
  end

  private

  def black?
    number.start_with?('60141') && (number.length == 17 || number.length == 16)
  end

  def red?
    valid_rgb_length? && number.start_with?('6014352')
  end

  def green?
    valid_rgb_length? && green_range.member?(number.to_i)
  end

  def blue?
    valid_rgb_length? && valid_start?
  end

  def valid_rgb_length?
    number.length == 16
  end

  def green_range
    6_014_355_526_000_000..6_014_355_529_000_001
  end

  def valid_start?
    number.start_with?('6014')
  end
end
