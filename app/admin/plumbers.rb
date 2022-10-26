ActiveAdmin.register Plumber do
  config.filters = false
  permit_params :name, :address, :vehicles
end
