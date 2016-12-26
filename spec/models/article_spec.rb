require 'spec_helper'

describe Article do
  let(:articles) { create_list(:article, 5, title: 'test_title') }

  it 'search' do
    result = Article.search(articles.first.title)
    expect(result.size).to eq(5)
  end

  it 'title can not be empty' do
    article = build(:article, title: '')
    expect(article).not_to be_valid
  end

  it 'Title can not be shorter than 5' do
    article = build(:article, title: 'titl')
    expect(article).not_to be_valid
  end

  it 'text can not be empty' do
    article = build(:article, text: '')
    expect(article).not_to be_valid
  end

  it 'text can not be shorter than 5' do
    article = build(:article, text: 'text')
    expect(article).not_to be_valid
  end

  it 'date must be current date' do
    article = build(:article, create_date: Date.current-1)
    expect(article).not_to be_valid
  end


  it 'price can not be empty' do
    article = build(:article, price: '')
    expect(article).not_to be_valid
  end

  it 'price can not be less than than 0' do
    article = build(:article, price: -1)
    expect(article).not_to be_valid
  end
end
