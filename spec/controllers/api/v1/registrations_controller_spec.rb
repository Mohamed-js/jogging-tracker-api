require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
    let(:valid_attributes) { { email: 'atefhamosa@gmail.com', password: '123123'  }  }
    let(:invalid_attributes) { { email: 'atefhamosa@gmail.com', password: '123'  }  }

    describe 'POST /registrations' do
        context "with valid user info" do
            it "should create a user successfully & send token" do
                post :create, params: valid_attributes

                expect(response).to have_http_status(:success)
                expect(JSON.parse(response.body)["token"]).not_to be_nil
                expect(JSON.parse(response.body)["errors"]).to be_nil
            end
        end
        context "with invalid user info" do
            it "should raise an error & send errors" do
                post :create, params: invalid_attributes
                expect(response).to have_http_status(:unprocessable_entity)
                expect(JSON.parse(response.body)["token"]).to be_nil
                expect(JSON.parse(response.body)["errors"]).not_to be_nil
            end
        end
    end
end