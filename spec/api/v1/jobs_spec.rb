# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Jobs, type: :request do
  let(:admin_user) { create :admin_user }
  let(:token) { create :api_token, admin_user: admin_user }

  describe 'GET /jobs assigned' do
    let!(:plumber) { create :plumber }
    let!(:job) { create :job, plumber: plumber }

    let(:params) { nil }

    subject { signed_get '/api/v1/jobs', token: token, params: params }

    context 'when case has job assigned' do
      let(:params) { { plumber_id: plumber.id, start_time_period: Date.today, end_time_period: Date.today + 1.year } }

      it 'response!' do
        expect(subject.count).to be(1)
      end
    end

    context 'when case has not job assigned' do
      let(:params) { { plumber_id: plumber.id, start_time_period: Date.today - 5.days, end_time_period: Date.today - 2.days } }

      it 'response!' do
        expect(subject.count).to be(0)
      end
    end
  end

  describe 'PUT /status_job' do
    let!(:plumber) { create :plumber }
    let!(:client) { create :client }
    let!(:job) { create :job, plumber: plumber, client: client, status: :assigned }

    let(:params) { nil }

    subject { signed_put '/api/v1/status_job', params: params }

    context 'when case valid and updated status' do
      let(:params) { { plumber_id: plumber.id, job_id: job.id } }


      it 'response' do
        subject
        expect(job.reload.status).to eq('finished')
      end

      it 'success' do
        is_expected.to be_truthy
      end
    end

    context 'when case invalid' do
      let(:params) { { plumber_id: plumber.id, job_id: 999 } }

      it 'response' do
        subject
        expect(subject['message']).to eq "Job ID 999 not belongs to #{plumber.name}"
        expect(subject['success']).to eq false
      end
    end
  end
end
