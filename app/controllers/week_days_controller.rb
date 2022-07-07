class WeekDaysController < ApplicationController
  before_action :set_week_day, only: %i[ show edit update destroy ]

  # POST /week_days or /week_days.json
  def create
    @week_day = WeekDay.new(week_day_params)

    respond_to do |format|
      if @week_day.save
        format.html { redirect_to request.referrer, notice: "L'orario è stato creato correttamente" }
      format.js {render inline: "location.reload();" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @week_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /week_days/1 or /week_days/1.json
  def update
    respond_to do |format|
      if @week_day.update(week_day_params)
        format.html { redirect_to request.referrer, notice: "L'orario è stato modificato correttamente" }
      format.js {render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @week_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /week_days/1 or /week_days/1.json
  def destroy
    @week_day.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "L'orario è stato rimosso correttamente" }
      format.js {render inline: "location.reload();" }
    end
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
