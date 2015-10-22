class Element < ActiveRecord::Base
  belongs_to :node

  validates :title, presence: true
end
