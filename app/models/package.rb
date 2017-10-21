class Package < ApplicationRecord
  has_many :package_authors, dependent: :destroy
  has_many :authors, through: :package_authors, source: :user

  has_many :package_maintainers, dependent: :destroy
  has_many :maintainers, through: :package_maintainers, source: :user

  validates :name, presence: true, uniqueness: true
  validates :version, presence: true
  validates :published_at, presence: true
end
