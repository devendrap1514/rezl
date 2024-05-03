class Account < ApplicationRecord
  has_many :account_terms, dependent: :destroy
  has_many :term_and_conditions, through: :account_terms

  has_many :account_property_terms, dependent: :destroy
  has_many :property_term_and_conditions, through: :account_property_terms

  validates :name, presence: true
end
