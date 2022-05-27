class FavouriteSpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favourite_space, only: %i[ show edit update destroy ]

  # GET /favourite_spaces or /favourite_spaces.json
  def index
    @favourite_spaces = FavouriteSpace.all
  end

  # GET /favourite_spaces/1 or /favourite_spaces/1.json
  def show
  end

  # GET /favourite_spaces/new
  def new
    @favourite_space = FavouriteSpace.new
  end

  # GET /favourite_spaces/1/edit
  def edit
  end

  # POST /favourite_spaces or /favourite_spaces.json
  def create
    @favourite_space = FavouriteSpace.new(favourite_space_params)

    respond_to do |format|
      if @favourite_space.save
        format.html { redirect_to favourite_space_url(@favourite_space), notice: "Favourite space was successfully created." }
        format.json { render :show, status: :created, location: @favourite_space }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favourite_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favourite_spaces/1 or /favourite_spaces/1.json
  def update
    respond_to do |format|
      if @favourite_space.update(favourite_space_params)
        format.html { redirect_to favourite_space_url(@favourite_space), notice: "Favourite space was successfully updated." }
        format.json { render :show, status: :ok, location: @favourite_space }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favourite_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favourite_spaces/1 or /favourite_spaces/1.json
  def destroy
    @favourite_space.destroy

    respond_to do |format|
      format.html { redirect_to favourite_spaces_url, notice: "Favourite space was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favourite_space
      @favourite_space = FavouriteSpace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favourite_space_params
      params.require(:favourite_space).permit(:email, :department, :typology, :space)
    end
end
