class Video < ActiveRecord::Base
	belongs_to :category
	has_many :reviews,  -> { order(created_at: :desc) }

	validates :title, presence: true
	validates :description, presence: true

	def self.search_by_title(search_term)
		search_term = search_term.downcase
		where("lower(title) LIKE ?", "%#{search_term}%").order("created_at DESC")
	end

end