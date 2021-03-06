require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, session: { name: 'Example User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar' }
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete :destroy
      response.should redirect_to root_path
    end
  end
end
