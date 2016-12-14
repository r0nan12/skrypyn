require 'spec_helper'
require 'support/controller_macros'

describe ArticlesController do
  login_user('admin')
  let(:article) { create(:article) }

  describe 'show action' do
    it 'render show if article exist' do
      get :show, params: { id: article.id }
      expect(response).to render_template('show')
    end

    it 'render 404 page if article not exist' do
      get :show, params: { id: article.id+1}
      expect(response.status).to eq(404)
    end

    describe 'create action' do
      it 'redirect to articles' do
        process :create, method: :post, params: { article: attributes_for(:article) }
        expect(response).to redirect_to(assigns(:article))
      end
    end

    describe 'new action' do
      it 'render New if user logined' do
        get :new
        expect(response).to render_template('new')
      end
      it 'redirect to root_path if user not logined' do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end
end
