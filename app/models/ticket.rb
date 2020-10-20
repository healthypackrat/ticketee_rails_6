class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  has_and_belongs_to_many :watchers, -> { distinct },
    join_table: "ticket_watchers",
    class_name: "User"
  has_many_attached :attachments

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  before_create :assign_default_state

  searcher do
    label :tag, from: :tags, field: "name"
    label :state, from: :state, field: "name"
  end

  private

  def assign_default_state
    self.state ||= State.default
  end
end
