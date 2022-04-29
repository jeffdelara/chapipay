require 'rails_helper'

RSpec.describe Category, type: :model do 
  describe 'validate' do 
    context 'image' do 
      it 'valid' do 
        category = Category.new 
        category.name = 'Test'
        expect(category).not_to be_valid
      end
    end
  end
end
