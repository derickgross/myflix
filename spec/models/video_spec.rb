require 'spec_helper'

describe Video do
	it { should belong_to(:category)}
	it { should validate_presence_of(:title)}
	it { should validate_presence_of(:description)}

	describe "search_by_title" do
		it "returns an empty array if there is no match" do
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.")
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.")
			expect(Video.search_by_title("Airwolf")).to eq([])
		end

		it "returns an array of one video for an exact match" do
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.")
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.")
			expect(Video.search_by_title("Fringe")).to eq([fringe])
		end

		it "returns an array of one video for a partial match" do
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.")
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.")
			expect(Video.search_by_title("ring")).to eq([fringe])
		end

		it "returns an array of all matches ordered by created_at" do
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.", created_at: 2.day.ago)
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.", created_at: 1.day.ago)
			expect(Video.search_by_title("r")).to eq([doctor_who, fringe])
		end
	end

end