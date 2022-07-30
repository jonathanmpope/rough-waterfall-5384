require 'rails_helper'

RSpec.describe 'the customer show page' do 
    it 'has a customer show page with a list of itmes and the supermarket they belong to' do 
        dans = Supermarket.create!(name: "Dan's Food'n'stuff", location: "Townville")
        whole_paycheck = Supermarket.create!(name: "We want all your money", location: "Moneyville")
        person1 = dans.customers.create!(name: "Boaty McBoatface")
        person2 = whole_paycheck.customers.create!(name: "Sally McSalad")
        person1.items.create!(name:"ham", price: 1300)
        person1.items.create!(name:"bread", price: 500)
        person1.items.create!(name:"gouda", price: 2000)
        person2.items.create!(name:"wine", price: 2500)

        visit "/customers/#{person1.id}"

        expect(page).to_not have_content("We want all your money")
        expect(page).to_not have_content("wine")
        expect(page).to_not have_content("Sally McSalad")

        expect(page).to have_content("Boaty McBoatface")
        expect(page).to have_content("Dan's Food'n'stuff")
        expect(page).to have_content("ham")
        expect(page).to have_content("bread")
        expect(page).to have_content("gouda")
    end 
end 