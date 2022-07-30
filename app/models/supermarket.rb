class Supermarket < ApplicationRecord
  has_many :customers

  def supermarket_items_list 
    customers.joins(:items).select('items.*').distinct
  end 
end