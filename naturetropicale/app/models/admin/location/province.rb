class Admin::Location::Province < ApplicationRecord
  has_many :regions, :class_name => "Admin::Location::Region"

  def self.search(query)
    return all.order('name asc') if query.blank?
    build_where_query(all, query).order('name asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("name ILIKE ?", "%#{query[:query]}%") unless query[:query].blank?
    queries
  end
end
