class PlotPlantsController < ApplicationController

  def destroy
    plot_plant = PlotPlant.find_by(plot_id: params[:plot_id], plant_id: params[:plant_id])
    plot_plant.destroy
    redirect_to "/plots"
  end
end