module Api::V1
  class PointsController < ApplicationController
    def create
      if check_point
        if check_point.distance > params[:point][:distance]
          check_point.update(distance: params[:point][:distance])
          render json: 'Distance successfully updated'
        else
          render json: 'There is already a point with a shorter path'
        end
      else
        @point = Point.new(point_params)
        if @point.save
          render json: @point, status: :created
        else
          render json: @point.errors, status: :unprocessable_entity
        end
      end
    end

    def cost
      if check_weight
        render json: 'Weight must be between 1 and 50'
      else
        path = Dijkstra.new(params[:origin].upcase, params[:destination].upcase, params[:weight].to_i, matrix)
        if path.cost.class != Array
          render json: "Shipping price: R$ #{'%.2f' % path.cost}"
        else
          render json: 'No path found for points provided'
        end
      end
    end

    private

    def check_point
      Point.where(startpoint: params[:point][:startpoint], endpoint: params[:point][:endpoint]).first rescue nil
    end

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