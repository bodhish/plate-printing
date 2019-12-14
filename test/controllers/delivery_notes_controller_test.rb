require 'test_helper'

class DeliveryNotesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get delivery_notes_index_url
    assert_response :success
  end

  test "should get create" do
    get delivery_notes_create_url
    assert_response :success
  end

end
