class Point < ApplicationRecord
  validates :startpoint, :endpoint, :distance, presence: true
  validates_with PointValidator
  before_save :format_inputs

  private

  def format_inputs
    self.startpoint.upcase!
    self.endpoint.upcase!
  end

end
