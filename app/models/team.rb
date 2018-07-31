class Team
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :employee_id, type: String
  field :color, type: String

  auto_increment :sequence, collection: :teams

  validates :first_name, presence: true
  validates :last_name, presence: true, uniqueness: { scope: :first_name }
  validates :employee_id, presence: true, uniqueness: true

  after_create :random_color

  default_scope { order('first_name asc') }

  private

  def random_color
    color = self.sequence % 4
    self.color = color > 0 ? color : 4
    save
  end
end
