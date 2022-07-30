require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
  end

  describe 'instance methods' do
    describe '#supermarket_items_list' do
      it 'shows the uniq list of items for a supermarket' do 
        whole_paycheck = Supermarket.create!(name: "We want all your money", location: "Moneyville")
        dans = Supermarket.create!(name: "Dan's Food'n'stuff", location: "Townville")

        person1 = whole_paycheck.customers.create!(name: "Boaty McBoatface")
        person2 = whole_paycheck.customers.create!(name: "Sally McSalad")
        person3 = dans.customers.create!(name: "Super Cool")
        
        ham = Item.create!(name:"ham", price: 1300)
        bread = Item.create!(name:"bread", price: 500)
        gouda = Item.create!(name:"gouda", price: 2000)
        wine = Item.create!(name:"wine", price: 2500)
        salsa = Item.create!(name:"salsa", price: 280)
        icecream = Item.create!(name:"icecream", price: 750)

        CustomerItem.create!(item: ham, customer: person1)
        CustomerItem.create!(item: bread, customer: person1)
        CustomerItem.create!(item: gouda, customer: person1)
        CustomerItem.create!(item: wine, customer: person1)
        CustomerItem.create!(item: salsa, customer: person2)
        CustomerItem.create!(item: bread, customer: person2)
        CustomerItem.create!(item: gouda, customer: person2)
        CustomerItem.create!(item: icecream, customer: person3)

        expect(whole_paycheck.supermarket_items_list.count).to eq(5)
        expect(whole_paycheck.supermarket_items_list[0].name).to eq("ham")
        expect(whole_paycheck.supermarket_items_list[4].name).to eq("salsa")
      end 
    end 

    describe '#top_three_items' do
      it 'shows the top three items for that supermarket' do 
        whole_paycheck = Supermarket.create!(name: "We want all your money", location: "Moneyville")

        person1 = whole_paycheck.customers.create!(name: "Boaty McBoatface")
        person2 = whole_paycheck.customers.create!(name: "Sally McSalad")
        person3 = whole_paycheck.customers.create!(name: "Super Cool")
        person4 = whole_paycheck.customers.create!(name: "Super Cool")
        person5 = whole_paycheck.customers.create!(name: "Super Cool")
        person6 = whole_paycheck.customers.create!(name: "Super Cool")
        
        ham = Item.create!(name:"ham", price: 1300)
        bread = Item.create!(name:"bread", price: 500)
        gouda = Item.create!(name:"gouda", price: 2000)
        wine = Item.create!(name:"wine", price: 2500)
        salsa = Item.create!(name:"salsa", price: 280)
        icecream = Item.create!(name:"icecream", price: 750)

        CustomerItem.create!(item: ham, customer: person1)
        CustomerItem.create!(item: bread, customer: person1)
        CustomerItem.create!(item: icecream, customer: person1)
        CustomerItem.create!(item: wine, customer: person1)
        CustomerItem.create!(item: salsa, customer: person2)
        CustomerItem.create!(item: bread, customer: person2)
        CustomerItem.create!(item: gouda, customer: person2)
        CustomerItem.create!(item: icecream, customer: person2)
        CustomerItem.create!(item: icecream, customer: person3)
        CustomerItem.create!(item: bread, customer: person3)
        CustomerItem.create!(item: icecream, customer: person4)
        CustomerItem.create!(item: bread, customer: person4)
        CustomerItem.create!(item: salsa, customer: person4)
        CustomerItem.create!(item: icecream, customer: person5)
        CustomerItem.create!(item: bread, customer: person5)
        CustomerItem.create!(item: salsa, customer: person5)
        CustomerItem.create!(item: icecream, customer: person6)

        expect(whole_paycheck.top_three_items[0].name).to eq("icecream")
        expect(whole_paycheck.top_three_items[1].name).to eq("bread")
        expect(whole_paycheck.top_three_items[2].name).to eq("salsa")
      end 
    end 
  end 
end