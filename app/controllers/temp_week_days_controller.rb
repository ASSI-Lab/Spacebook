class TempWeekDaysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_temp_week_day, only: %i[ show edit update destroy ]

  # GET /temp_week_days or /temp_week_days.json
  def index
    @temp_week_days = TempWeekDay.all
  end

  # GET /temp_week_days/1 or /temp_week_days/1.json
  def show
  end

  # GET /temp_week_days/new
  def new
    @temp_week_day = TempWeekDay.new
  end

  # GET /temp_week_days/1/edit
  def edit
  end

  # POST /temp_week_days or /temp_week_days.json
  def create
    @temp_week_day = TempWeekDay.new(temp_week_day_params)

    respond_to do |format|
      if @temp_week_day.save
        format.html { redirect_to request.referrer, notice: "L'orario è stato registrato correttamente" }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @temp_week_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_week_days/1 or /temp_week_days/1.json
  def update
    respond_to do |format|
      if @temp_week_day.update(temp_week_day_params)
        format.html { redirect_to request.referrer, notice: "L'orario è stato modificato correttamente" }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @temp_week_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_week_days/1 or /temp_week_days/1.json
  def destroy
    @temp_week_day.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "L'orario è stato rimosso correttamente" }
      format.js {render inline: "location.reload();" }
    end
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
