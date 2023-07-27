require 'rails_helper'

RSpec.describe Api::V1::JoggingTimesController, type: :controller do
  # TESTING VARIABLES
  # User types
  let(:regular_user) { User.create!(email: 'regular_user@gmail.com', password: '123123') }
  let(:user_manager) { User.create!(email: 'user_manager@gmail.com', password: '123123', role: 'user_manager') }
  let(:admin) { User.create!(email: 'admin@gmail.com', password: '123123', role: 'admin') }

  # Jogging times
  let(:jogging_time) { regular_user.jogging_times.create!(date: Date.today, distance: 2.2, time: 20) }
  let(:jogging_time_two) { regular_user.jogging_times.create!(date: Date.today, distance: 23, time: 50) }

  # Jogging times attributes
  let(:valid_attributes) { { jogging_time: { distance: 200, time: 80, date: Date.today } } }
  let(:valid_attributes_two) { { jogging_time: { distance: 24.6, time: 20 } } }
  let(:invalid_attributes) { { jogging_time: { distance: '200s' } } }

  describe 'All /jogging_times requests' do
    context 'when user is a user manager' do
      before { allow(controller).to receive(:current_user).and_return(user_manager) }
      it 'should unauthorize all requests' do
        get :index
        expect(response).to have_http_status(:unauthorized)
        get :show, params: { id: jogging_time.id }
        expect(response).to have_http_status(:unauthorized)
        put :update, params: { id: jogging_time.id }
        expect(response).to have_http_status(:unauthorized)
        post :create
        expect(response).to have_http_status(:unauthorized)
        delete :destroy, params: { id: jogging_time.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  # Index method
  describe 'GET /jogging_times' do
    context 'when user is a regular user' do
      before { allow(controller).to receive(:current_user).and_return(regular_user) }
      it 'should return a list of jogging times for the current user' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
    context 'when user is an admin' do
      before { allow(controller).to receive(:current_user).and_return(admin) }
      it 'should filter jogging times by date range' do
        from_date = Date.today - 7.days
        to_date = Date.today
        get :index, params: { from_date: from_date, to_date: to_date }
        expect(response).to have_http_status(:success)
      end
    end
  end


  # Show method
  describe 'GET /jogging_times/:id' do
    context 'when user is a regular user' do
      before { allow(controller).to receive(:current_user).and_return(regular_user) }
      it 'should return the specified jogging time' do
        get :show, params: { id: jogging_time.id }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['id']).to eq(jogging_time.id)
      end
    end
  end


  # Create method
  describe 'POST /jogging_times' do
    # WITH VALID ENTRIES
    context 'when the request is valid' do
      context 'when user is an admin' do
        before { allow(controller).to receive(:current_user).and_return(admin) }
        it 'should create a jogging time successfully' do
          post :create, params: valid_attributes
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['time']).to eq(80)
          expect(JSON.parse(response.body)['distance']).to eq(200)
        end
      end
    end
    # WITH INVALID ENTRIES
    context 'when the request is invalid' do
      context 'when user is a regular user' do
        before { allow(controller).to receive(:current_user).and_return(regular_user) }
        it 'should return user errors' do
          post :create, params: invalid_attributes
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors'].length).to eq(4)
        end
      end
      context 'when user is an admin' do
        before { allow(controller).to receive(:current_user).and_return(admin) }
        it 'should return user errors' do
          post :create, params: { jogging_time: { distance: 1 } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors'].length).to eq(3)
        end
      end
    end
  end


  # Update method
  describe 'PUT /jogging_times/:id' do
    # WITH VALID ENTRIES
    context 'when the request is valid' do
      context 'when user is a regular user' do
        before { allow(controller).to receive(:current_user).and_return(regular_user) }
        it 'should update the specified jogging time' do
          put :update, params: { id: jogging_time.id, jogging_time: { time: 30, distance: 500 } }
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['time']).to eq(30)
          expect(JSON.parse(response.body)['distance']).to eq(500)
        end
      end
      context 'when user is an admin' do
        before { allow(controller).to receive(:current_user).and_return(admin) }
        it 'should update the specified jogging time' do
          put :update, params: { id: jogging_time.id, jogging_time: { time: 10, distance: 100 } }
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['time']).to eq(10)
          expect(JSON.parse(response.body)['distance']).to eq(100)
        end
      end
    end
    # WITH INVALID ENTRIES
    context 'when the request is invalid' do
      context 'when user is a regular user' do
        before { allow(controller).to receive(:current_user).and_return(regular_user) }
        it 'should return user errors' do
          put :update, params: { id: jogging_time.id, jogging_time: { time: '30s' } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
      context 'when user is an admin' do
        before { allow(controller).to receive(:current_user).and_return(admin) }
        it 'should return user errors' do
          put :update, params: { id: jogging_time.id, jogging_time: { distance: 'asd' } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  # Destroy method
  describe 'DELETE /jogging_times/:id' do
    context 'when user is a regular user' do
      before { allow(controller).to receive(:current_user).and_return(regular_user) }
      it 'delete the specified jogging time' do
        delete :destroy, params: { id: jogging_time.id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
