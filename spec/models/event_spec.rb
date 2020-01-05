require 'rails_helper'

RSpec.describe Event, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  # タイトル、候補日、URLが未入力ではないこと
  before do 
    @event1 = Event.create(
       title: "進捗会議",
       candidate_date:      "2020-01-09 10:00〜",
       url:   SecureRandom.urlsafe_base64
     )

    @event2 = Event.create(
       title: "新年会",
       candidate_date:      "2020-01-06 18:00〜",
       url:   SecureRandom.urlsafe_base64
    )

    @event3 = Event.create(
       title: "新入社員歓迎会",
       candidate_date:      "2020-02-12 18:00〜",
       url:   SecureRandom.urlsafe_base64
    )
  end
  it "Title, Candidate, URL must not be blank" do
    require 'securerandom'
    event = Event.new(
       title: "test",
       candidate_date:      "2020-01-01 18:00〜",
       url:   SecureRandom.urlsafe_base64
     )
     expect(event).to be_valid
  end

  # 独自のURLでなければ無効であること
  it "Invalid unless it is your own URL" do 
    Event.create(
       title: "test",
       candidate_date:      "2020-01-01 18:00〜",
       url:   "test12345"
     )

    event = Event.new(
       title: "test",
       candidate_date:      "2020-01-01 18:00〜",
       url:   "test12345"
     )
    event.valid?
    expect(event.errors[:url]).to include("has already been taken")
  end

  # 一致するデータが見つかるとき
  context "when a match is found" do
    # 検索文字列に一致するイベントを返すこと
    it "returns events that match the search term" do
         expect(Event.search("進捗会議")).to include(@event1, @event3)
    end
  end

  
end
