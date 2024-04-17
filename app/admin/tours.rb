ActiveAdmin.register Tour do
  config.filters = false

  permit_params :property_id, :status, :invitee_name, :phone_number
end
