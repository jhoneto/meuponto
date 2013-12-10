require 'spec_helper'

describe DailySummary do
  before do
    @user = FactoryGirl.create(:user)
  end
  
  context "get current value" do
    it "insert one day values" do
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '08:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '12:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '13:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '19:00')
      expect(DailySummary.current_value(@user)).to eq(2.0)
    end
    
    it "insert two day values" do
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '08:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '12:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '13:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '19:00')
      
      FactoryGirl.create(:working_hour, day: "11/12/2013", user_id: @user.id, record: '08:00')
      FactoryGirl.create(:working_hour, day: "11/12/2013", user_id: @user.id, record: '12:00')
      FactoryGirl.create(:working_hour, day: "11/12/2013", user_id: @user.id, record: '13:00')
      FactoryGirl.create(:working_hour, day: "11/12/2013", user_id: @user.id, record: '19:00')
      
      expect(DailySummary.current_value(@user)).to eq(4.0)
    end
    
  end
end
