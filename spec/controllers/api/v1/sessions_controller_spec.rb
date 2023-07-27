require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
    
    let(:valid_attributes) { { email: 'demo@gmail.com', password: '123123'  }  }
    let(:invalid_attributes) { { email: 'demo@gmail.com', password: '123'  }  }

    describe 'POST /sessions' do
        before { User.create!(email: "demo@gmail.com", password: "123123") }

        context "with valid user info" do
            it "should send user token" do
                post :create, params: valid_attributes
                expect(response).to have_http_status(:success)
                expect(JSON.parse(response.body)["token"]).not_to be_nil
                expect(JSON.parse(response.body)["errors"]).to be_nil
            end
        end
        context "with invalid user info" do
            it "should raise an error & send errors" do
                post :create, params: invalid_attributes
                expect(response).to have_http_status(:unauthorized)
                expect(JSON.parse(response.body)["token"]).to be_nil
                expect(JSON.parse(response.body)["errors"]).not_to be_nil
            end
        end
    end

    describe 'DELETE /sessions' do
        before { @user = User.create!(email: "demo2@gmail.com", password: "123123") }

        context "with valid user id" do
            it "should be successfull" do
                delete :destroy, params: {id: @user.id}
                expect(response).to have_http_status(:success)
            end
        end
        context "with invalid user id" do
            it "should send not found status" do
                delete :destroy, params: {id: 100}
                expect(response).to have_http_status(:not_found)
            end
        end
    end
end