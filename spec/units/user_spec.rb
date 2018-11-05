require 'user'

describe User do

  let(:test_user) {{name: 'Stan Testson', email: 'stan@stan.com', password: 'password123'}}

  before do
    insert_user_into_test_database
  end

  describe '.create' do
    it 'inserts the user into the database' do
      user = User.create(name: test_user[:name], email: test_user[:email], password: test_user[:password]).first
      expect(user['name']).to eq test_user[:name]
      expect(user['email']).to eq test_user[:email]
      expect(user['password']).to eq test_user[:password]
      expect(user['id']).to eq '2'
    end
  end

  describe '.all' do
    it 'creates User object' do
      user = User.all.first
      expect(user.id).to eq '1'
      expect(user.name).to eq test_user[:name]
      expect(user.email).to eq test_user[:email]
      expect(user.password).to eq test_user[:password]
    end
  end
end