require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) {FactoryBot.create :user}
  let!(:params) {FactoryBot.attributes_for :user}

  context "when guests don't need login" do

    describe "POST #create" do
      context "when valid param" do
        let!(:count_all_users) {User.count}
  
        before {post :create, params: {user: params}}
  
        it "should increase User.count" do
          expect(User.count).to eq count_all_users + 1
        end
  
        it "should redirect root url" do
          expect(response).to redirect_to root_url
        end
  
        it "should return success message" do
          expect(flash[:success]).to eq I18n.t("users.create.success")
        end
      end
  
      context "when invalid param" do
        before {post :create, params: {user: {name: ""}}}
  
        it "should render view new" do
          expect(response).to render_template :new
        end
  
        it "should return error message" do
          expect(flash[:error]).to eq I18n.t("users.create.error")
        end
      end
    end
  end
end
