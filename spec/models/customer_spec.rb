require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items) }
  end


  describe 'instance methods' do
    describe '#total_cost' do
      it 'calculates the total cost of all items for a customer' do 
        dans = Supermarket.create!(name: "Dan's Food'n'stuff", location: "Townville")
        person1 = dans.customers.create!(name: "Boaty McBoatface")
        person1.items.create!(name:"ham", price: 1300)
        person1.items.create!(name:"bread", price: 500)
        person1.items.create!(name:"gouda", price: 2000)

        expect(person1.total_cost).to eq(3800)
      end 
    end 
  end 
end