# frozen_string_literal: true

module V1
  class Jobs < Grape::API
    helpers do
      def request
        @request ||= ::Grape::Request.new(env)
      end

      def authenticate!
        headers = Hashie::Mash.new(request.headers)
        auth = V1::Auth::Authenticator.new(request, headers)
        auth.authenticate!
      end
    end

    desc 'jobs with period time' do
      headers Auth::Desc.headers
      success V1::Entities::Job
      is_array true
    end
    params do
      requires :plumber_id, type: Integer, desc: 'Plumber ID'
      requires :start_time_period, type: DateTime, desc: 'Start Period time'
      requires :end_time_period, type: DateTime, desc: 'End Period time'
    end
    get '/jobs' do
      authenticate!
      plumber = Plumber.find(params[:plumber_id])
      jobs =  plumber.jobs.where("DATE(time_period) >= ? AND DATE(time_period) <= ?", params[:start_time_period], params[:end_time_period])
      present jobs, with: V1::Entities::Job
    end


    desc 'Update status of job to finish' do
      success V1::Entities::SimpleResponse
    end
    params do
      requires :plumber_id, type: Integer, desc: 'Plumber ID'
      requires :job_id, type: Integer, desc: 'Job ID'
    end

    put '/status_job' do
      plumber = Plumber.find(params[:plumber_id])

      unless plumber.jobs.find_by(id: params[:job_id])
        present({ success: false, message: "Job ID #{params[:job_id]} not belongs to #{plumber.name}" }, with: V1::Entities::SimpleResponse)
      else
        job = plumber.jobs.find_by(id: params[:job_id])
        job.update(status: :finished)

        present({ success: true }, with: V1::Entities::SimpleResponse)
      end
    end
  end
end