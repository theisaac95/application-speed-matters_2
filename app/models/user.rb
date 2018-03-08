class User < ActiveRecord::Base
  has_many :points

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :username,
            presence: true,
            length: { minimum: 2, maximum: 32 },
            format: { with: /^\w+$/, multiline: true },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            format: { with: /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i, multiline: true },
            uniqueness: { case_sensitive: false }

  def self.by_total_points
    joins(:points).group('users.id').order('SUM(points.value) DESC')
    order(total_points: :desc)
  end

  def total_points
    self.points.sum(:value)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
