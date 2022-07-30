require 'rails_helper'

RSpec.describe 'the supermarket show page' do 
    it 'has a show page with the name and a link to view all of the items the supermarket has' do 
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

        visit "/supermarkets/#{whole_paycheck.id}"

        expect(page).to have_content("We want all your money")
        expect(page).to have_content("View all items")
        expect(page).to_not have_content("ham")

        click_link("View all items")

        expect(current_path).to eq("/supermarkets/#{whole_paycheck.id}/items")

        expect(page).to have_content("ham", count: 1)
        expect(page).to_not have_content("bread", count: 2)
        expect(page).to have_content("bread", count: 1)
        expect(page).to have_content("gouda", count: 1)
        expect(page).to_not have_content("gouda", count: 2)
        expect(page).to have_content("wine", count: 1)
        expect(page).to have_content("salsa", count: 1)
        expect(page).to_not have_content("icecream")
    end 
end 