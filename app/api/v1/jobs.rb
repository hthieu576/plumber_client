# frozen_string_literal: true

module V1
  class Jobs < Grape::API
    desc 'jobs' do
      headers Auth::Desc.headers
      success V1::Entities::Job
    end
    get '/jobs' do
      jobs =  Job.all
      present jobs, with: V1::Entities::Job
    end
  end
end