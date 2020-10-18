class State < ApplicationRecord
  validates :name, :color, presence: true

  def make_default!
    State.update_all(default: false)
    update!(default: true)
  end

  def to_s
    name
  end
end
