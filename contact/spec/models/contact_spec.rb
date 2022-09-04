require 'rails_helper'

RSpec.describe Contact, type: :model do

  context 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:phone_number)}
    it {should validate_uniqueness_of(:email) }
  end

end