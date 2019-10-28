module Api::V1
  class PointsController < ApplicationController
    def create
      @point = Point.new(point_params)
      if @point.startpoint == @point.endpoint
        render json: 'Points cannot be equal'
      elsif @point.distance > 100000
        render json: 'Distance must be less than 100000'
      elsif @point.save
        render json: @point, status: :created
      else
        render json: @point.errors, status: :unprocessable_entity
      end
    end

    def cost
      if check_weight
        render json: 'Weight must be between 1 and 50'
      else
        path = Dijkstra.new(params[:origin], params[:destination], params[:weight].to_i, matrix)
        if path.cost.class != Array
          render json: path.cost
        else
          render json: 'No path found for points provided'
        end
      end
    end

    private

    def check_weight
      weight = params[:weight].to_i
      return true if weight > 50 || weight <= 0
    end

    def matrix
      @r_left = Point.pluck(:startpoint, :endpoint, :distance)
      @r_right = Point.pluck(:endpoint, :startpoint, :distance)
      @r = @r_left + @r_right
    end

    def point_params
      params.require(:point).permit(:startpoint, :endpoint, :distance)
    end
  end
end