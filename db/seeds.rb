# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

video_list = [
	[ "Aliens", "Ellen Ripley is the lone survivor of an encounter with an aggressive alien species, but reluctantly accompanies a team of marines on a mission to rescue a space colony from her nemesis", '/images/small_cover_jpgs/aliens.jpg', '/images/large_cover_jpgs/aliens.jpg', 1 ],
	[ "The Matrix", "A hacker named Neo joins the human resistance against rogue artificial intelligence", '/images/small_cover_jpgs/matrix.jpg', '/images/large_cover_jpgs/matrix.jpg', 2 ],
	[ "The Dark Knight", "Vigilante crime fighter Batman must make difficult choices to combat an unpredictable foe with nothing to lose", '/images/small_cover_jpgs/dark_knight.jpg', '/images/large_cover_jpgs/dark_knight.jpg', 3 ],
	[ "Aliens", "Ellen Ripley is the lone survivor of an encounter with an aggressive alien species, but reluctantly accompanies a team of marines on a mission to rescue a space colony from her nemesis", '/images/small_cover_jpgs/aliens.jpg', '/images/large_cover_jpgs/aliens.jpg', 1 ],
	[ "The Matrix", "A hacker named Neo joins the human resistance against rogue artificial intelligence", '/images/small_cover_jpgs/matrix.jpg', '/images/large_cover_jpgs/matrix.jpg', 2 ],
	[ "The Dark Knight", "Vigilante crime fighter Batman must make difficult choices to combat an unpredictable foe with nothing to lose", '/images/small_cover_jpgs/dark_knight.jpg', '/images/large_cover_jpgs/dark_knight.jpg', 3 ],
	[ "Aliens", "Ellen Ripley is the lone survivor of an encounter with an aggressive alien species, but reluctantly accompanies a team of marines on a mission to rescue a space colony from her nemesis", '/images/small_cover_jpgs/aliens.jpg', '/images/large_cover_jpgs/aliens.jpg', 1 ],
	[ "The Matrix", "A hacker named Neo joins the human resistance against rogue artificial intelligence", '/images/small_cover_jpgs/matrix.jpg', '/images/large_cover_jpgs/matrix.jpg', 2 ],
	[ "The Dark Knight", "Vigilante crime fighter Batman must make difficult choices to combat an unpredictable foe with nothing to lose", '/images/small_cover_jpgs/dark_knight.jpg', '/images/large_cover_jpgs/dark_knight.jpg', 3 ]
]

video_list.each do |title, description, small_image, large_image, category_id|
	Video.create( title: title, description: description, small_cover_url: small_image, large_cover_url: large_image, category_id: category_id )
end

space_action = Category.create(name: "Space Action")
ai_action = Category.create(name: "AI Action")
superhero_action = Category.create(name: "Superhero Action")

derick = User.create(full_name: "Derick Gross", password: "password", email: "derick@example.com")

Review.create(user: derick, video: Video.first, rating: 5, content: "Amazing movie!")
Review.create(user: derick, video: Video.first, rating: 1, content: "Too sad!")