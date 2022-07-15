class WeekDaysController < ApplicationController
  before_action :set_week_day, only: %i[ show edit update destroy ]

  def create
    @week_day = WeekDay.new(week_day_params)

    respond_to do |format|
      if @week_day.save
        flash[:alert] = "L'orario per '#{@week_day.day}' è stato creato correttamente"
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @week_day.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week_day
      @week_day = WeekDay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def week_day_params
      params.require(:week_day).permit(:department_id, :dep_name, :day, :state, :apertura, :chiusura)
    end
end
