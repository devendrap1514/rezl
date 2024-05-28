class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :admin_terms, dependent: :destroy
  has_many :term_and_conditions, through: :admin_terms

  def accepted?
    return true if unaccepted_terms.empty?
    false
  end

  def unaccepted_terms
    TermAndCondition.all - term_and_conditions
  end
end
