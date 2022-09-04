class PostCategory < ApplicationRecord
  has_many :subcategories, :class_name => "PostCategory", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent, :class_name => "PostCategory",:optional => true
  has_many :profiles
  has_many :jobs
end
