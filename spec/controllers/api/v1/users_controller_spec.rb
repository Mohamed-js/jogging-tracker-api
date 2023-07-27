require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # TESTING VARIABLES
  # User types
  let(:regular_user) { User.create!(email: 'regular_user@gmail.com', password: '123123') }
  let(:user_manager) { User.create!(email: 'user_manager@gmail.com', password: '123123', role: 'user_manager') }
  let(:admin) { User.create!(email: 'admin@gmail.com', password: '123123', role: 'admin') }

  # User attrs
  let(:valid_attributes) { { user: { email: 'atefhamosa@gmail.com', password: '123123' } }  }
  let(:invalid_attributes) { { user: { email: 'atefhamosa', password: '12312' } }  }


  describe 'All /users requests by a regular user' do
    
      before { allow(controller).to receive(:current_user).and_return(regular_user) }
      it 'should be unauthorized' do
        get :index
        expect(response).to have_http_status(:unauthorized)
        get :show, params: { id: user_manager.id }
        expect(response).to have_http_status(:unauthorized)
        put :update, params: { id: user_manager.id }
        expect(response).to have_http_status(:unauthorized)
        post :create
        expect(response).to have_http_status(:unauthorized)
        delete :destroy, params: { id: user_manager.id }
        expect(response).to have_http_status(:unauthorized)
      end
    
  end

   # Index method
  describe 'GET /users' do

      before { allow(controller).to receive(:current_user).and_return(user_manager) }
      it 'should return a list of all users' do
        get :index
        expect(response).to have_http_status(:success)
      end
    
  end


   # Show method
  describe 'GET /users/:id' do
   
      before { allow(controller).to receive(:current_user).and_return(user_manager) }
      it 'should return the specified user' do
        get :show, params: { id: regular_user.id }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['id']).to eq(regular_user.id)
      end
    
  end


  # Create method
  describe 'POST /users' do
     # WITH VALID ENTRIES
    context 'when the request is valid' do
     
        before { allow(controller).to receive(:current_user).and_return(user_manager) }
        it 'should create a user successfully' do
          post :create, params: valid_attributes
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['email']).to eq('atefhamosa@gmail.com')
          expect(JSON.parse(response.body)['role']).to eq('regular_user')
        end
     
    end
    # WITH INVALID ENTRIES
    context 'when the request is invalid' do
        before { allow(controller).to receive(:current_user).and_return(user_manager) }
        it 'should returns an error' do
          post :create, params: invalid_attributes
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors'].length).to eq(2)
        end
    end
  end


  # Update method
  describe 'PUT /users/:id' do
    # WITH VALID ENTRIES
    context 'when the request is valid' do
      
        before { allow(controller).to receive(:current_user).and_return(user_manager) }
        it 'should update the specified user' do
          put :update, params: { id: regular_user.id, user: { email: "hamo@gmail.com"} }
          expect(response).to have_http_status(:success)
        end
      
    end
    # WITH INVALID ENTRIES
    context 'when the request is invalid' do
      
        before { allow(controller).to receive(:current_user).and_return(user_manager) }
        it 'should raise an error' do
          put :update, params: { id: regular_user.id, user: { email: 'hamoda' } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    
  end


   # Destroy method
  describe 'DELETE /users/:id' do
   
      before { allow(controller).to receive(:current_user).and_return(user_manager) }
      it 'should delete the specified users' do
        delete :destroy, params: { id: regular_user.id }
        expect(response).to have_http_status(:success)
      end
    
  end
end
