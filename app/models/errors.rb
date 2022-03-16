class Errors
  class InvalidCardNumberLengthError < StandardError; end
  class InvalidNumberFormatError < StandardError; end
  class InvalidNumberError < StandardError; end
  class InvalidAlgorithmError < StandardError; end
end
