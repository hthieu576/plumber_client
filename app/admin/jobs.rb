ActiveAdmin.register Job do
  permit_params :description, :client_id, :time_period, :status, :plumber_id

  form do |f|
    f.inputs do
      f.input :description
      f.input :client_id, as: :select, collection: Client.all.collect { |client| [client.name, client.id] }
      f.input :plumber_id, as: :select, collection: f.object.new_record? ? Plumber.available.collect { |plumber| [plumber.name, plumber.id] } : Plumber.all.collect { |plumber| [plumber.name, plumber.id] }, multiple: f.object.new_record? ? true : false
      f.input :time_period, as: :date_time_picker, picker_options: { min_date: Date.current }
    end

    f.actions
  end

  controller do
    def create
      params[:job][:plumber_id].compact_blank.each do |plumber_id|
        job = Job.new(permitted_params[:job])
        job.plumber_id = plumber_id
        job.save
      end
      redirect_to admin_jobs_path, notice: 'Created successfully'
    end
  end
end
