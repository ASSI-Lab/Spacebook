class LeafletOsmController < ApplicationController
  def index
      @departments = Department.all
  end
end
