namespace :db do
	desc "Fill m_ordinary_publishers table with sample data"
	task populate: :environment do
		999.times do |n|
			name = Faker::Name.name
			url = "#{name}.com"
			Position.create!(name: name, url: url, publisher_id: 6, channel_id: 1006, state_id: 1, material_id: 1, layout_id: 1, format_id: 1, dimension_id: 1, size: 100, serving_id: 1, payment_id: 1, user_id: 1, adtype_id: 1)
		end
	end
end
