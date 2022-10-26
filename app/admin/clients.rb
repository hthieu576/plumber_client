ActiveAdmin.register Client do
  config.filters = false
  permit_params :name, :address, :age, :private_note
end
