ActiveAdmin.register Client do
  permit_params :name, :address, :age, :private_note
end
