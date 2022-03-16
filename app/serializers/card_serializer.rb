class CardSerializer < ActiveModel::Serializer
  attributes :id, :number, :type, :balance
end