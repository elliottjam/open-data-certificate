require 'test_helper'

class CertificatesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "published certificates can be shown" do
    cert = FactoryGirl.create(:published_certificate_with_dataset)
    get :show, {dataset_id: cert.response_set.dataset.id, id: cert.id}
    assert_response :success
  end

  test "unpublished certificates can't be shown" do
    cert = FactoryGirl.create(:certificate_with_dataset)
    get :show, {dataset_id: cert.response_set.dataset.id, id: cert.id}
    assert_response 404
  end
  
  test "unpublished certificates can be shown to their creator" do
    user = FactoryGirl.create(:user)
    sign_in user
  
    cert = FactoryGirl.create(:certificate_with_dataset)
    cert.response_set.assign_to_user! user
    
    get :show, {dataset_id: cert.response_set.dataset.id, id: cert.id}
    
    assert_response :success
  end

end
