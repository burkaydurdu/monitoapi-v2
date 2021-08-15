# frozen_string_literal: true

class TodoSerializer < ActiveModel::Serializer
  attributes :id, :content, :done, :created_at, :updated_at
end
