require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user) {FactoryBot.build(:user)}
    let(:ticket1) {FactoryBot.build(:ticket)}
    let(:ticket2) {FactoryBot.build(:ticket)}
    it 'ensure first_name presence' do
      user.first_name = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure last_name presence' do
      user.last_name = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure email presence' do
      user.email = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure first_name only content [a-z][A-Z]' do
      user.first_name = 're23wan'
      expect(user.valid?).to eq(false)   
    end

    it 'ensure last_name only content [a-z][A-Z]' do
      user.last_name = '12a234b'
      expect(user.valid?).to eq(false)   
    end

    it 'ensure password presence' do
      user.encrypted_password = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure phone number presence' do
      user.phone = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure user_name presence' do
      user.user_name = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure user role presence' do
      user.role = nil
      expect(user.valid?).to eq(false)
    end

    it 'ensure phone number has minimum 10 and character' do
      user.phone="123456789";
      expect(user.valid?).to eq(false)
    end

    it 'ensure phone number has maximum 15 and character' do
      user.phone="1234567893034567";
      expect(user.valid?).to eq(false)
    end

    it 'ensure phone number string contain only digit' do
      user.phone="0195mflgotj44";
      expect(user.valid?).to eq(false)
    end

    it 'ensure email is unique' do
      User.create(first_name:"redwan",last_name:"ahmed",email:"redwan@gmail.com",user_name:"redwan",encrypted_password:"12345687",phone:"+8801564555654")
      another_user = User.create(first_name:"imtiaz",last_name:"rafi",email:"redwan@gmail.com",user_name:"imtiaz",encrypted_password:"12345687",phone:"+8801564555666")
      expect(another_user.valid?).to eq(false)
    end

    it 'ensure email is in correct format' do
      user.email = "1format.com"
      expect(URI::MailTo::EMAIL_REGEXP.match?(user.email)).to eq(false)
    end


    it 'ensure user_name is unique' do
      User.create(first_name:"zobayer",last_name:"ahmed",email:"zobayer@gmail.com",user_name:"zobayer",encrypted_password:"12345687",phone:"+8801564555654")
      another_user = User.create(first_name:"sakib",last_name:"ahmed",email:"sakib@gmail.com",user_name:"zobayer",encrypted_password:"12345687",phone:"+8801564555666")
      expect(another_user.valid?).to eq(false)
    end

    #association testing
  it "ensure has many tickets" do
      user.tickets << [ticket1, ticket2]
      expect(user.tickets).to eq([ticket1, ticket2])
  end

  end
end
