class TermAndConditionsController < ApplicationController
  def index
    rezl_t_c = TermAndCondition.all
    property_t_c = Property.find_by(id: params[:property_code]).property_term_and_conditions
    render json: {
      rezl_terms_and_conditions: TermAndConditionSerializer.new(rezl_t_c),
      property_terms: TermAndConditionSerializer.new(property_t_c)
    }
  end

  def accept_terms
    rezl_t_c = TermAndCondition.none
    property_t_c = PropertyTermAndCondition.none
    terms = params[:terms].each do |item|
      class_name = item[:type]
      class_id = item[:id]
      class_name.constantize
      if class_name.present? && ActiveRecord::Base.descendants.map(&:name).include?(class_name)
        class_name = class_name.constantize
        term = class_name.find(class_id)
        term.class == PropertyTermAndCondition ? property_t_c = property_t_c.or(class_name.where(id: class_id)) : rezl_t_c = rezl_t_c.or(class_name.where(id: class_id))
      end
    end
    check_terms_accepted(rezl_t_c, property_t_c)
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Invalid token"] }
  rescue NoMethodError => e
    render json: { errors: [e.message] }
  rescue NameError => e
    render json: { errors: [e.message] }
  rescue TypeError => e
    render json: { errors: [e.message] }
  end

  def check_terms_accepted(rezl_t_c, property_t_c)
    byebug
  end

  def find_user
    @account = Account.find(params[:token])
  end
end
