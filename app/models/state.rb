class State < ApplicationRecord
  validates :name, :color, presence: true

  def to_s
    name
  end
end
