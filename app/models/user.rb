class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: { allow_blank: true }

  def full_name
    return name if email.blank?
    "#{name} (#{email})"
  end
end
