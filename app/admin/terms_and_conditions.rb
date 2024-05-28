ActiveAdmin.register TermAndCondition do
  permit_params :title, :description

  collection_action :updated_terms, method: :get do
    @page_title = "Updated Terms and Conditions"
  end

  collection_action :accept_terms, method: :post do
    @page_title = "Updated Terms and Conditions"
    term_ids = (params[:term_ids] || []).map(&:to_i)
    rezl_t_c = TermAndCondition.where(id: term_ids)

    if (current_admin_user.unaccepted_terms - rezl_t_c).empty?
      current_admin_user.term_and_conditions << rezl_t_c
      redirect_to admin_root_path, notice: "Successfully Accepted"
    else
      flash.now[:error] = 'You have to accept all the terms and conditions.'
      render :updated_terms, status: :unprocessable_entity
    end
  end

  show do
    attributes_table do
      row :title
      row :description do |object|
        raw object.description
      end
    end
  end

  form do |f|
    f.inputs 'TermAndCondition' do
      f.input :title
      f.input :description, as: :quill_editor
    end
    f.actions
  end

  controller do
    before_action only: %i[updated_terms accept_terms] do
      redirect_to admin_root_path if current_admin_user.accepted?
    end
  end
end
