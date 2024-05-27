# app/admin/terms_acceptance.rb
ActiveAdmin.register TermAndCondition do
  permit_params :title, :description

  collection_action :accept_terms, method: :post do

  end

  collection_action :unaccepted_terms, method: :get do
    @unaccepted_terms = TermAndCondition.where.not(id: current_admin_user.term_and_conditions.pluck(:id))
  end
end
