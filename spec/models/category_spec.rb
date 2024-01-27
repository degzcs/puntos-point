require 'rails_helper'

describe Category, type: :model do
  it 'has a valid factory' do
    expect(create(:category)).to be_valid
  end
end
