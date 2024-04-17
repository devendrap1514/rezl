ActiveAdmin.register Property do
  config.filters = false

  permit_params :name, :calendly_token
end
