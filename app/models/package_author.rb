class PackageAuthor < ApplicationRecord
  belongs_to :package
  belongs_to :user

  validates :user_id, uniqueness: { scope: :package_id }
end
