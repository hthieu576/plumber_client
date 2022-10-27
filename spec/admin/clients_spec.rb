# frozen_string_literal: true

require 'rails_helper'

describe Admin::ClientsController, type: :controller do
  let(:admin_user) { create :admin_user }

  before { sign_in admin_user }

  describe 'GET /clients' do
    let(:client) { create :client }
    before { get :index }

    it 'response status' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /clients/:id' do
    let(:client) { create :client }

    before { get :show, params: { id: client.id } }

    it 'response status' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /clients/:id' do
    let(:params) do
      {
        client: {
          name: 'adam', address: 'Ho Chi Minh City', age: '25', private_note: 'testing'
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
      expect(Client.last.name).to eq 'adam'
    end
  end
end