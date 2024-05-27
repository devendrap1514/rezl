class TermAndCondition < ApplicationRecord
  has_many :account_terms, dependent: :destroy
  has_many :accounts, through: :account_terms

  has_many :admin_terms, dependent: :destroy
  has_many :admin_users, through: :admin_terms

  validates :title, :description, presence: true
end
