class Api::V1::GroupsController < ApplicationController

    def index
      if params[:company_id]
        @groups = Group.where(company_id: params[:company_id])
      else
        @groups = Group.all
      end

      respond_to do |format|
        format.json { render json: @groups }
    end
  end
end