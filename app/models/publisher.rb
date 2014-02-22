class Publisher < ActiveRecord::Base
	has_many :channels, dependent: :destroy
	before_save do
		self.name = name.downcase
		self.url = url.downcase
	end
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :url, presence: true
	
	def self.search(type, keywords)
		if type and keywords and !keywords.empty?
			if type == 'id'
				find(:all, conditions: ['id = ?', keywords.to_i])
			elsif type == 'name'
				find(:all, conditions: ['name LIKE ?', "%#{keywords}%"])
			else
				find(:all)
			end
		else
			find(:all)
		end
	end

end
