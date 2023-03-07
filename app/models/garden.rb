class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plots

  def unique_list
    plants.distinct.where("days_to_harvest < 100").pluck(:name)
  end
end
