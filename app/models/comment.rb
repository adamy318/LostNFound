class Comment < ApplicationRecord
  attr_accesssible :body, :commenter, :post
  belongs_to :post
end
