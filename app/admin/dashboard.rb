# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: 'Currently allocated jobs' do 
    render 'dashboard', jobs: Job.allocated
  end
  # content title: 'Currently allocated jobs' do
  #   # table_for Job.allocated do
  #   #   column :id
  #   #   column :description
  #   #   column(:client_name) { |job| job.client.name }
  #   #   column(:client_address) { |job| job.client.address }
  #   #   column(:plumber_name) { |job| job.plumber.name }
  #   #   column(:plumber_address) { |job| job.plumber.address }
  #   #   column(:vehicles) { |job| job.plumber.vehicles }
  #   #   column :time_period
  #   #   column("Estimate Distance(km)") { |job| job.estimate_distance }
  #   #   column("Estimate Arrival Time(mins)") { |job| job.estimate_time_by_vehicles }
  #   # end
  # end

end
