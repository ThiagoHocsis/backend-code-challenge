class Point < ApplicationRecord
  validates :startpoint, :endpoint, :distance, presence: true
end
