require 'spec_helper'

describe QueueItemsController do
	describe "GET index" do
		it "sets @queue_items to the queue items of the logged in user" do
			alice = Fabricate(:user)
			session[:user_id] = alice.id
			queue_item1 = Fabricate(:queue_item, user: alice)
			queue_item2 = Fabricate(:queue_item, user: alice)
			get :index
			expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
		end

		it "redirects to the sign in page for unauthenticated users" do
			get :index
			expect(response).to redirect_to sign_in_path
		end
	end

	describe "POST create" do
		it "redirects to the my queue page" do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(response).to redirect_to my_queue_path
		end

		it "creates a queue item" do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(QueueItem.count).to eq(1)
		end

		it "creates a queue item that is associated with a video" do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(QueueItem.first.video).to eq(video)
		end

		it "creates a queue item that is associated with a signed in user" do
			session[:user_id] = Fabricate(:user).id
			video = Fabricate(:video)
			post :create, video_id: video.id
			expect(QueueItem.first.user.id).to eq(session[:user_id])
		end

		it "puts the most recently created queue item at the end of the queue" do
			session[:user_id] = Fabricate(:user).id

			video = Fabricate(:video)
			video2 = Fabricate(:video)
			video3 = Fabricate(:video)
			video4 = Fabricate(:video)
			video5 = Fabricate(:video)
			video6 = Fabricate(:video)

			post :create, video_id: video.id
			post :create, video_id: video2.id
			post :create, video_id: video3.id
			post :create, video_id: video4.id
			post :create, video_id: video5.id
			post :create, video_id: video6.id

			expect(QueueItem.last.video).to eq(video6)
		end

		it "does not add duplicate entries to the queue" do
			session[:user_id] = Fabricate(:user).id

			video = Fabricate(:video)
			video2 = Fabricate(:video)
			video3 = Fabricate(:video)
			video4 = Fabricate(:video)
			video5 = Fabricate(:video)
			video6 = Fabricate(:video)

			post :create, video_id: video.id
			post :create, video_id: video2.id
			post :create, video_id: video3.id
			post :create, video_id: video4.id
			post :create, video_id: video5.id
			post :create, video_id: video5.id

			expect(QueueItem.count).to eq(5)
		end

		it "redirects to the sign in page for unauthenticated users" do
			post :create, video_id: 5
			expect(response).to redirect_to sign_in_path
		end
	end

	describe "DELETE destroy" do
		it "redirects to the my queue page" do
			session[:user_id] = Fabricate(:user).id
			queue_item = Fabricate(:queue_item)
			delete :destroy, id: queue_item.id
			expect(response).to redirect_to my_queue_path
		end

		it "deletes the queue item" do
			cipriana = Fabricate(:user)
			session[:user_id] = cipriana.id
			queue_item = Fabricate(:queue_item, user: cipriana)
			delete :destroy, id: queue_item.id
			expect(QueueItem.count).to eq(0)
		end

		it "does not delete the queue item if the queu item is not in the current user's queue" do
			cipriana = Fabricate(:user)
			obama = Fabricate(:user)
			session[:user_id] = cipriana.id
			queue_item = Fabricate(:queue_item, user: obama)
			delete :destroy, id: queue_item.id
			expect(QueueItem.count).to eq(1)
		end

		it "redirects to the sign in page for unauthenticated users" do
			delete :destroy, id: 3
			expect(response).to redirect_to sign_in_path
		end
	end
end



































