class Team < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_create :random_color

  private

  def random_color
    self.color = %w[1 2 3 4].random
  end
end
