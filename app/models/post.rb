class Post < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :purpose

  with_options presence: true do
    validates :name
    validates :text
    validates :place
    validates :image
  end
  validates :purpose_id, numericality: { other_than: 1 } 
end
