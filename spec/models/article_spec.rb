require 'spec_helper'

describe Article do
  it 'calculate total coments for each articles' do
    coment1 = create(:coment)
    coment2 = create(:coment)
    article = create(:article)
    article.coments << coment1
    article.coments << coment2
    article.calculate_coments
    expect(article.total_coments).to eq(2)
  end

  it 'search' do
    5.times do
      article = create(:article, title: 'test_title')
    end
    articles = Article.search('test_title')
    expect(articles.size).to eq(5)
  end
end
