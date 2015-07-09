require 'rails_helper'

describe UsersController do
  describe 'GET#index' do
    it "populates an array of all users"
    it "renders the :index template"
  end

  describe 'GET#show' do
    it "assigns the requested user to @show_user" do
      user = create(:user)
      get :show, id: user
      expect(assigns(:user)).to eq user
    end
    it "renders the :show template" do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end
  end
end
