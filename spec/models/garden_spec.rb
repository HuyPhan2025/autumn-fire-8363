require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe '#instance methods' do
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

    it "should have unique list of plants" do
      expect(growth.unique_list).to eq(["Cherry", "Lettus"])
    end

    xit "should have list of plants appearing in garden from most to least" do
      expect(growth.order_list).to eq(["Cherry", "Pepper", "Lettues", "Onion"])
    end
  end
end
