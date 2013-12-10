require 'spec_helper'

describe WorkingHour do
  before do
    @user = FactoryGirl.create(:user)
  end
  context "save new record" do
    it "is valid" do
      expect(FactoryGirl.build(:working_hour, day: "10/12/2013", user_id: @user.id, record: '08:00')).to be_valid
    end
    it "is invalid without day" do
      expect(FactoryGirl.build(:working_hour, day: nil, user_id: @user.id, record: '08:00')).to have(1).errors_on(:day)
    end
    it "is invalid without user" do
      expect(FactoryGirl.build(:working_hour, day: "10/12/2013", user_id: nil, record: '08:00')).to have(1).errors_on(:user_id)
    end
    it "is invalid without record" do
      expect(FactoryGirl.build(:working_hour, day: "10/12/2013", user_id: @user.id, record: nil)).to have(1).errors_on(:record)
    end
  end
  context "calculate balance" do
    it "after insert all day records" do
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '08:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '12:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '13:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '17:00')
      expect(WorkingHour.today_total(@user)).to eq("8:0")
    end   
  end
  context "get daily summary" do
    it "after insert all day records" do
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '08:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '12:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '13:00')
      FactoryGirl.create(:working_hour, day: "10/12/2013", user_id: @user.id, record: '19:00')
      daily_summary = DailySummary.where("day = ? and user_id = ?", "10/12/2013", @user.id).first
      expect(daily_summary.value).to eq(2.00)
    end
  end
end
