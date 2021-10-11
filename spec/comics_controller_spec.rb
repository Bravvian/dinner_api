# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ComicsController, type: :controller do
  let(:params) { { limit: 40 } }
  let(:invalid_params) { { title: 'no movie title' } }
  let(:update_params) { { comic_id: 99, favorite: true } }

  describe 'GET comics List' do
    context 'with a valid params' do
      before do
        get :index, params: params
      end

      it 'responds with a status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a list of 20' do
        expect(response.parsed_body['data']['results'].size).to be(40)
      end
    end

    context 'with invalid params' do
      before do
        get :index, params: invalid_params
      end

      it 'responds with a message error' do
        expect(response.parsed_body['data']['results'].size).to be(0)
      end
    end
  end

  describe 'Update comic' do
    context 'with valid params' do

      it 'creates or updates 1 on record' do
        put :update, params: update_params
        expect(Comic.find_by(api_comic_id: update_params[:comic_id]).favorite).to be(update_params[:favorite])
      end

    end
  end
end
