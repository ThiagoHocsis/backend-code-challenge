class PointValidator < ActiveModel::Validator
  def validate(record)
      if record.startpoint == record.endpoint
        record.errors.add(:same_points, 'Points cannot be equal')
      elsif record.distance > 100000
        record.errors.add(:distance, 'Distance must be less than 100000')
      end
  end
end