class PostSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :title, :content, :created_at, :updated_at
  # model association
  has_one :category

  # def cache_key
  #   [object, scope]
  # end
end
