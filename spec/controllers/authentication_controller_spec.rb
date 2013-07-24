=begin
require 'spec_helper'

describe UsersController do

  describe "for non-signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

    describe "submitting to the update action" do
      before { put user_path(user) }
      specify { response.should redirect_to(signin_path) }
    end

    describe "submitting a PUT request to the Users#update action" do
      
      before do
        sign_in user
        put user_path(wrong_user) 
      end
      specify { response.should redirect_to(root_path) }
    end
  end
  
  describe "as non-admin user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:non_admin) { FactoryGirl.create(:user) }

    before { sign_in non_admin }

    describe "submitting a DELETE request to the Users#destroy action" do
      before { delete user_path(user) }
      specify { response.should redirect_to(root_path) }
    end
  end
end
=end