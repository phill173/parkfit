require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected when logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "Should show the new page when logged in" do
    sign_in users(:phillip)
    get :new
    assert_response :success
  end

  test "Should be logged in to create StatusesControllerTest" do
    post :create, status: {content: "Hello"}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end


  test "should create status when logged in" do
    sign_in users(:phillip)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content}
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status for current user when logged in" do
    sign_in users(:phillip)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:jim).id }
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:phillip).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get edit when logged in" do
    sign_in users(:phillip)
    get :edit, id: @status
    assert_response :success
  end

  test "should redirect update status when not logged in" do
    put :update, id: @status, status: { content: @status.content}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "Should update status when logged in" do
    sign_in users(:phillip)
    put :update, id: @status, status: { content: @status.content}
    assert_redirected_to status_path(assigns(:status)) 
end

test "Should update status for the current user when logged in" do
    sign_in users(:phillip)
    put :update, id: @status, status: { content: @status.content, user_id: users(:jim).id}
    assert_redirected_to status_path(assigns(:status)) 
    assert_equal assigns(:status).user_id, users(:phillip).id
end

test "Should not update if nothing has changed" do
    sign_in users(:phillip)
    put :update, id: @status
    assert_redirected_to status_path(assigns(:status)) 
    assert_equal assigns(:status).user_id, users(:phillip).id
end



  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
