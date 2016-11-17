module ControllerMacros
  def login_user(roles)
    before(:each) do
      @request.env["users.mapping"] = Devise.mappings[:user]
      role = Role.find_by(name: roles);
      user = create(:user, role_id: role.id)
      sign_in user, scope: :user
    end
  end
end