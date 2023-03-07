require 'rails_helper'

RSpec.describe '/gardens/:id' do
  describe 'As a visitor' do
    describe 'When I visit the garden show page' do
      let!(:growth) {Garden.create!(name: "Growth", organic: true)}

      let!(:plot1) { growth.plots.create!(number: 1, size: "Large", direction: "West") }
      let!(:plot2) { growth.plots.create!(number: 2, size: "Small", direction: "East") }
      let!(:plot3) { growth.plots.create!(number: 3, size: "Small", direction: "North") }

      let!(:cherry) { Plant.create!(name: "Cherry", description: "Needs good soil and lots of sun", days_to_harvest: 60)}
      let!(:lettus) { Plant.create!(name: "Lettus", description: "Needs little soil and lots of water", days_to_harvest: 30)}
      let!(:pepper) { Plant.create!(name: "Pepper", description: "Needs good soil and little of water", days_to_harvest: 125)}
      let!(:onion) { Plant.create!(name: "Onion", description: "Needs soil and medium of water", days_to_harvest: 145)}

      before do
        PlotPlant.create!(plot: plot1, plant:cherry)
        PlotPlant.create!(plot: plot1, plant:pepper)
        PlotPlant.create!(plot: plot1, plant:lettus)
        PlotPlant.create!(plot: plot2, plant:cherry)
        PlotPlant.create!(plot: plot2, plant:pepper)
        PlotPlant.create!(plot: plot2, plant:onion)
        PlotPlant.create!(plot: plot3, plant:cherry)
      end

      it 'should see a list of unique plant that are less than 100 days to harvest' do
        visit "/gardens/#{growth.id}"

        expect(page).to have_content("#{cherry.name}").once
        expect(page).to have_content("#{lettus.name}").once
        expect(page).to_not have_content("#{onion.name}")
        expect(page).to_not have_content("#{pepper.name}")
      end

      xit 'should see a list of plants sorted by number of times the plants appears in the garden from most to least' do
        visit "/gardens/#{growth.id}"

        expect("Cherry").to appear_before("Pepper")
        expect("Pepper").to appear_before("Lettus")
      end
    end
  end
end