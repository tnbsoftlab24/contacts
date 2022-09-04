class Admin::Location::Region < ApplicationRecord
  belongs_to :province, :class_name => "Admin::Location::Province"
  has_many   :villes, :class_name => "Admin::Location::Ville"

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
