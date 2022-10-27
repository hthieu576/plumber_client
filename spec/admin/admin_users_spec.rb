# frozen_string_literal: true

require 'rails_helper'

describe Admin::AdminUsersController, type: :controller do
  let(:admin_user) { create :admin_user }

  before { sign_in admin_user }

  describe 'GET /admin_users' do

    before { get :index }

    it 'esponse status' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin_users/:id' do
    let(:admin_user) { create :admin_user }

    before { get :show, params: { id: admin_user.id } }

    it 'response status!' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /admin_users/:id' do
    let(:params) do
      {
        admin_user: {
          email: 'testing@example.com', password: 'password', password_confirmation: 'password'
        }
      }
    end

    subject do
      post :create, params: params
      response
    end

    it 'works!' do
      subject
      expect(response.status).to eq 302
    end

    it 'new record!' do
      subject
      expect(AdminUser.last.email).to eq 'testing@example.com'
    end
  end
end