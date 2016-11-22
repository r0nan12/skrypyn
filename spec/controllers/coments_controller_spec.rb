require 'spec_helper'
require 'support/controller_macros'

describe ComentsController do
  login_user('author')
  describe 'create action' do
    it 'redirect to article if comment created' do
      article = create(:article, user: @user)
      process :create, method: :post, params: { coment: { text: 'comment' }, article_id: article.id }
      expect(response).to redirect_to(assigns(:article))
    end
  end
end
