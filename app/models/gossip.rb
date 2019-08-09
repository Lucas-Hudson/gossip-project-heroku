class Gossip < ApplicationRecord
  validates :title, :length => { :minimum => 3, :maximum   => 14 }
  validates :content, :presence => true
  belongs_to :user
  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :join_table_gossip_tags
  has_many :tags, through: :join_table_gossip_tags
  has_many :likes, :as => :likeable, dependent: :destroy
end
