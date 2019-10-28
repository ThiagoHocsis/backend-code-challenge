require 'rails_helper'

describe Point do
  let!(:point) {create(:point)}
  it 'must be valid' do
    expect(point).to be_valid
  end

  it 'It must be 2 points and distance 5' do
    expect(point.startpoint).to eq('A')
    expect(point.endpoint).to eq('B')
    expect(point.distance).to eq(5)
  end

  it 'Must be return a distance error' do
    invalid_point = Point.new(startpoint: 'A', endpoint: 'B', distance:100000000000)
    invalid_point.valid?
    invalid_point.errors[:distance].should include('Distance must be less than 100000')
  end

  it 'Must be return same points error' do
    invalid_point = Point.new(startpoint: 'A', endpoint: 'A', distance:10)
    invalid_point.valid?
    invalid_point.errors[:same_points].should include('Points cannot be equal')
  end

  it 'Must be contains all fields' do
    invalid_point = Point.new
    invalid_point.valid?
    invalid_point.errors[:startpoint].should include("can't be blank")
    invalid_point.errors[:endpoint].should include("can't be blank")
    invalid_point.errors[:distance].should include("can't be blank")
  end

end