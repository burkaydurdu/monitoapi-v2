# frozen_string_literal: true
#
require "rails_helper"

RSpec.describe User, type: :model do
  let(:name)     { "Monito" }
  let(:surname)  { "Monito" }
  let(:email)    { "monito@example.com" }
  let(:password) { "Test.234" }
  let!(:user) do
    FactoryBot.create(:user, name: name,
                             surname: surname,
                             email: email,
                             password: password,
                             password_confirmation: password)
  end

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
end
