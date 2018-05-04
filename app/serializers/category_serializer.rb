class CategorySerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :created_at, :updated_at
  # model association

  # def cache_key
  #   [object, scope]
  # end
end
