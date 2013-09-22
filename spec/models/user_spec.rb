require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create :user
  end

  context "destroy" do
    it "destroys dependent card" do
      @user.card = FactoryGirl.create(:card)
      @user.save
      expect do
        @user.destroy
      end.to change{Card.count}.by(-1)
    end
  end

    [:experience, :skill, :hobby, :education].each do |attr|
    it "destroys dependent experiences" do
      @user.send(ActiveSupport::Inflector.pluralize(attr)) << FactoryGirl.create(attr)
      expect do
        @user.destroy
      end.to change{ActiveSupport::Inflector.constantize(ActiveSupport::Inflector.camelize(attr)).send(:count)}.by(-1)
    end
  end
end
