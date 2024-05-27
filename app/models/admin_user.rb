class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :admin_terms, dependent: :destroy
  has_many :term_and_conditions, through: :admin_terms

  def all_terms_accepted?
    TermAndCondition.all.all? do |term|
      term_and_conditions.include?(term)
    end
  end
end
