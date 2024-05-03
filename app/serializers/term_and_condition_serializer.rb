class TermAndConditionSerializer < ApplicationSerializer
  attributes :id, :title, :description
  attributes :type do |object|
    object.class
  end
end
