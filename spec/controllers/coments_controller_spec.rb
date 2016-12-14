require 'spec_helper'
require 'support/controller_macros'

describe ComentsController do
  login_user('admin')
  let(:article) { create(:article, user: @user) }
  describe 'create action' do
    it 'redirect to article if comment created' do
      process :create, method: :post, params: { coment: attributes_for(:coment), article_id: article.id }
      expect(response).to redirect_to(assigns(:article))
    end
  end
end
