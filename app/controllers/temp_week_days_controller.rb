class TempWeekDaysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_temp_week_day, only: %i[ show edit update destroy ]

  def create
    @temp_week_day = TempWeekDay.new(temp_week_day_params)

    respond_to do |format|
      if @temp_week_day.save
        flash[:alert] = "L'orario per '#{@temp_week_day.day}' è stato registrato correttamente"
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @temp_week_day.update(temp_week_day_params)
        format.html { redirect_to request.referrer, notice: "L'orario per '#{@temp_week_day.day}' è stato modificato correttamente" }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @temp_week_day.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_week_day
      @temp_week_day = TempWeekDay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_week_day_params
      params.require(:temp_week_day).permit(:temp_dep_id, :dep_name, :day, :state, :apertura, :chiusura)
    end
end
