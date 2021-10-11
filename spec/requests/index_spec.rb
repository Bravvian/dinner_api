require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  let(:params) {  { ingredients: %w[Margarine Cognac] } }
  
  describe "GET recipes list" do
    
    before(:all) do
      Rails.application.load_seed
    end

    context 'with valid ingredients' do
      before do
        get :index, params: params
      end
      
      it 'responds with a status ok' do
        expect(response).to have_http_status(:ok)
      end
      
      it 'responds with 2 recipes' do
        expect(response.parsed_body.size).to be(2)
      end
    end

    context 'with no existing ingredients' do
      before do
        get :index, params: params
      end

      it 'responds with a status ok' do
        expect(response).to have_http_status(:ok)
      end
      
    end
  end
end
