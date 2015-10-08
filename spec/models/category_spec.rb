require 'spec_helper'

describe Category do
it { should validate_presence_of(:name) }

	it "saves itself" do
		category = Category.new(name: "comedies")
		category.save
		
		expect(Category.first).to eq(category)
	end

	it "has many videos" do
		action = Category.create(name: "Action")
		terminator = Video.create(title: "Terminator", description: "A cyborg travels back in time to kill Sarah Connor, whose unborn son will lead the human resistance against machines.", category: action)
		predator = Video.create(title: "Predator", description: "An alien with advanced technology hunts marines in a South East Asian jungle.", category: action)
		
		expect(action.videos).to eq([predator, terminator])
	end

	describe "#recent_videos" do
		it "returns the videos in reverse chronological order, according to created_at" do
			action = Category.create(name: "Action")
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.", category: action, created_at: 1.day.ago)
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.", category: action)

			expect(action.recent_videos).to eq([doctor_who, fringe])
			
		end
		it "returns all videos if there are fewer than 6 videos in the category" do
			action = Category.create(name: "Action")
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.", category: action, created_at: 1.day.ago)
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.", category: action)

			expect(action.recent_videos.count).to eq(2)
		end
		it "returns 6 videos if there are 6 or more videos in the category" do 
			action = Category.create(name: "Action")
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.", category: action)
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.", category: action)
			terminator = Video.create(title: "Terminator", description: "A cyborg travels back in time to kill Sarah Connor, whose unborn son will lead the human resistance against machines.", category: action)
			predator = Video.create(title: "Predator", description: "An alien with advanced technology hunts marines in a South East Asian jungle.", category: action)
			django_unchained = Video.create(title: "Django Unchained", description: "A freed slave is offered the chance to rescue his wife if he helps a bounty hunter find three men.", category: action)
			avatar = Video.create(title: "Avatar", description: "A human joins an alien race in their fight against human invaders.", category: action)
			sucker_punch = Video.create(title: "Sucker Punch", description: "Sex slaves being held against their will in a mental institution plot their escape.", category: action)
			
			expect(action.recent_videos.count).to eq(6)
		end

		it "returns the most recent 6 videos, according to created_at" do
			action = Category.create(name: "Action")
			fringe = Video.create(title: "Fringe", description: "An FBI agent teams up with a mentally unstable scientist and his son to solve bizarre cases.", category: action)
			doctor_who = Video.create(title: "Doctor Who", description: "An alien befriends humans and takes them on adventures across time and space in his ship, which looks like a 1950's British telephone box.", category: action)
			terminator = Video.create(title: "Terminator", description: "A cyborg travels back in time to kill Sarah Connor, whose unborn son will lead the human resistance against machines.", category: action)
			predator = Video.create(title: "Predator", description: "An alien with advanced technology hunts marines in a South East Asian jungle.", category: action)
			django_unchained = Video.create(title: "Django Unchained", description: "A freed slave is offered the chance to rescue his wife if he helps a bounty hunter find three men.", category: action)
			avatar = Video.create(title: "Avatar", description: "A human joins an alien race in their fight against human invaders.", category: action)
			sucker_punch = Video.create(title: "Sucker Punch", description: "Sex slaves being held against their will in a mental institution plot their escape.", category: action, created_at: 1.day.ago)

			expect(action.recent_videos).not_to include(sucker_punch)
		end

		it "returns an empty array if the category has no videos" do
			action = Category.create(name: "Action")
			expect(action.recent_videos).to eq([])
		end
	end
end