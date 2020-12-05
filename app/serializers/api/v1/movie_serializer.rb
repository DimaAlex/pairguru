# frozen_string_literal: true

class Api::V1::MovieSerializer < ActiveModel::Serializer
  attributes :id, :title
end
