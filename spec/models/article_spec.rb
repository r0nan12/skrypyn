require 'spec_helper'

describe Article do
  let(:articles) { create_list(:article, 5, title: 'test_title') }

  it 'search' do
    result = Article.search(articles.first.title)
    expect(result.size).to eq(5)
  end
end
