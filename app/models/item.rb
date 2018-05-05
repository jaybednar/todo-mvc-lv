class Item < ActiveRecord::Base
	belongs_to :list
	validates :description, presence: true 

	STATUS = {
		incomplete: 0, 
		complete: 1
	}


	def complete?
		self.status == STATUS[:complete]
	end 

	def incomplete?
		self.status == STATUS[:incomplete]
	end 
end



### belongs_to gives you: ###

# association  (@item.list  => the list this instance of item belongs to.)

# association=() (@item.list = @list) 

# build_association (@item.build_list)