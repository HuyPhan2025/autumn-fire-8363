class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plots

  def unique_list
    plants.distinct.where("days_to_harvest < 100").pluck(:name)
  end

  # def unique_list
  #  plants
  #  .distinct
  #  .select("plants.name, COUNT(plots.id) as plot_count")
  #  .where("days_to_harvest < 100")
  #  .group(:id)
  #  .order("plot_count DESC").pluck(:name)

  # plants
  # .select("plants.name, COUNT(plots.id) as plot_count")
  # .order("plot_count DESC").pluck(:name)
  # end
end
