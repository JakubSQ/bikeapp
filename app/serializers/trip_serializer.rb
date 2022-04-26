# frozen_string_literal: true

class TripSerializer < ActiveModel::Serializer
  attributes :distance, :price
end
