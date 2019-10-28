require 'rails_helper'
RSpec.describe 'PointsController', type: :request do
  first_point = Point.create(startpoint: 'A', endpoint: 'B', distance: 1)
  second_point = Point.create(startpoint: 'A', endpoint: 'D', distance: 6)
  third_point = Point.create(startpoint: 'B', endpoint: 'D', distance: 9)

  it 'will retrieve response code 200' do
    get '/api/v1/cost?origin=A&destination=D&weight=4'
    expect(response).to have_http_status(200)
  end

  it 'Must return the shipping value with the shortest path' do
    get '/api/v1/cost?origin=A&destination=D&weight=4'
    expect(response.body).to eq('Shipping price: R$ 3.60')
  end

  it 'Must return weight error' do
    get '/api/v1/cost?origin=A&destination=D&weight=1000'
    expect(response.body).to eq('Weight must be between 1 and 50')
  end

  it 'Should return that there is no path to the given points' do
    get '/api/v1/cost?origin=A&destination=N&weight=5'
    expect(response.body).to eq('No path found for points provided')
  end
end