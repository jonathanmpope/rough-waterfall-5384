class Supermarket < ApplicationRecord
  has_many :customers

  def supermarket_items_list 
    customers.joins(:items).select('items.*').distinct
  end 

  def top_three_items
    customers.joins(:items).select('items.*, COUNT(items.*) AS count').group('items.id').order('count desc').limit(3)
  end 
end