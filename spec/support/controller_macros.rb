module ControllerMacros
  def login_user
    before(:each) do
      @request.env["users.mapping"] = Devise.mappings[:user]
      role = FactoryGirl.create(:role)
      user = FactoryGirl.create(:user)
      sign_in :user, user
    end
  end


  def login_admin
    before(:each) do
      @request.env["users.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, role_id: 1)
      sign_in :user, user
    end
  end

end