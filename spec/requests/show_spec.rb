require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:params) {  { id: Recipe.first.id } }
  let(:invalid_params) {  { id: 200000 } }

  describe "GET recipe" do

    before(:all) do
      Rails.application.load_seed
    end

    context 'with valid id' do
      before do
        get :show, params: params
      end

      it 'responds with a status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with the correct recipe' do
        expect(response.parsed_body['id']).to equal(params[:id])
      end
    end

    context 'with invalid id' do
      before do
        get :show, params: invalid_params
      end

      it 'responds with a not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
