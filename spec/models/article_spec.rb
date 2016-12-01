require 'spec_helper'

describe Article do
  let(:article) { create(:article) }
  let(:comments) { create_list(:coment, 2, article: article) }
  let(:articles) { create_list(:article, 5, title: 'test_title') }

  it 'calculate total coments for each articles' do
    article.calculate_coments
    expect(article.total_coments).to eq(2)
  end

  it 'search' do
    articles = Article.search(articles.first.title)
    expect(articles.size).to eq(5)
  end
end
