require 'spec_helper'
require 'support/controller_macros'

describe ArticlesController do
login_user
  describe "show action" do
    it 'render show if article exist' do
      article = create(:article)
      get :show, params: { id: article.id }
      response.should render_template('show')
    end

    it "render 404 page if article not exist" do
      article = create(:article)
      get :show, params: { id: 0 }
      response.status.should == 404
    end

    describe "create acrion" do
      it "redirect to articles" do
        post :create, article: { title: "titssle", text: "textyy" ,create_date: "2016-11-07"}
        response.should redirect_to(assigns(:article))
      end
    end

    describe "new action" do
      it "render New if user logined" do
        get :new
        response.should render_template('new')
      end
      it "redirect to root_path if user not logined" do
        get :new
        response.should redirect_to root_path
      end
    end
  end
end