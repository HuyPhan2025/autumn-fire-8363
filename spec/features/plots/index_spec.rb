require 'rails_helper'

RSpec.describe '/plots' do
  describe 'As a visitor' do
    describe 'When I visit the plots index page' do
      let!(:growth) {Garden.create!(name: "Growth", organic: true)}
      let!(:wellness) {Garden.create!(name: "Wellness", organic: false)}

      let!(:plot1) { growth.plots.create!(number: 1, size: "Large", direction: "West") }
      let!(:plot2) { growth.plots.create!(number: 2, size: "Small", direction: "East") }

      let!(:cherry) { Plant.create!(name: "Cherry", description: "Needs good soil and lots of sun", days_to_harvest: 20)}
      let!(:lettus) { Plant.create!(name: "Lettus", description: "Needs little soil and lots of water", days_to_harvest: 30)}
      let!(:pepper) { Plant.create!(name: "Pepper", description: "Needs good soil and little of water", days_to_harvest: 25)}
      let!(:onion) { Plant.create!(name: "Onion", description: "Needs soil and medium of water", days_to_harvest: 45)}

      before do
        PlotPlant.create!(plot: plot1, plant:cherry)
        PlotPlant.create!(plot: plot1, plant:pepper)
        PlotPlant.create!(plot: plot1, plant:lettus)
        PlotPlant.create!(plot: plot2, plant:cherry)
        PlotPlant.create!(plot: plot2, plant:pepper)
        PlotPlant.create!(plot: plot2, plant:onion)
      end

      it 'should see plots number and it plants name' do
        visit '/plots'
        expect(page).to have_content("#{plot1.number}")
        expect(page).to have_content("#{plot2.number}")
        expect(page).to have_content("#{cherry.name}")
        expect(page).to have_content("#{pepper.name}")
        expect(page).to have_content("#{lettus.name}")
        expect(page).to have_content("#{onion.name}")
      end

      it 'should see a link to remove a plant from the plot and when click redirect back the plot index page where the plant is no longer in the plot but is still listed on the other plot it was in' do
        visit '/plots'
        
        within "#plot_id-#{plot1.id}" do
          expect(page).to have_link("Remove Plant #{pepper.name}")
          expect(page).to have_link("Remove Plant #{cherry.name}")
          expect(page).to have_link("Remove Plant #{lettus.name}")

          click_link("Remove Plant #{pepper.name}")

          expect(current_path).to eq("/plots")
          expect(page).to_not have_content(pepper.name)
          expect(page).to have_content(cherry.name)
          expect(page).to have_content(lettus.name)
        end
        
        within "#plot_id-#{plot2.id}" do
          expect(page).to have_content(pepper.name)
        end      
      end
    end
  end
end