class PropertyTermAndCondition < ApplicationRecord
  belongs_to :property
  has_many :account_terms, dependent: :destroy
  has_many :accounts, through: :account_terms

  validates :title, :description, presence: true
end
