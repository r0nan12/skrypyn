require 'spec_helper'

describe Coment do
  it 'text can not be empty' do
    comment = build(:coment, text: '')
    expect(comment).not_to be_valid
  end
end