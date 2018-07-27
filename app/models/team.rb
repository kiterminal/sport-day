class Team < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true, uniqueness: { scope: :first_name }
  validates :code, presence: true, uniqueness: true

  after_create :random_color

  private

  def random_color
    color = self.id % 4
    self.color = color > 0 ? color : 4
    save
  end
end
