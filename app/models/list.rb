class List < ActiveRecord::Base
	has_many :shared_lists 
	has_many :users, through: :shared_lists

	has_many :items 
	validates :name, presence: true 

	accepts_nested_attributes_for :items

	#Dynamic Definition (Metaprogramming)
	

	def self.permissions_for(*args)
		
		association = args[0]
		methods = args[1..-1].flatten 
		binding.pry
		methods.each do |method_name|
			define_method "#{method_name}able_by?" do |user|
				assoc = self.send(association).find_by(user_id: user.id)
				if !assoc
					return false 
				else 
					assoc.send("#{method_name}able?")
				end 
			end 
		end 

	end 

	permissions_for :shared_lists, :edit, :view, :destroy

	# permissions_for replaces:  

	# def viewable_by?(user)
	# 	shared_list = self.shared_lists.find_by(user_id: user.id)
	# 	if !shared_list 
	# 		return false 
	# 	else 
	# 		shared_list.viewable?
	# 	end 
	# end 

	# def editable_by?(user)
	# 	shared_list = self.shared_lists.find_by(user_id: user.id)
	# 	if !shared_list 
	# 		return false 
	# 	else 
	# 		shared_list.editable?
	# 	end 
	# end 

	# def destroyable_by?(user)
	# 	shared_list = self.shared_lists.find_by(user_id: user.id)
	# 	if !shared_list 
	# 		return false 
	# 	else 
	# 		shared_list.destroyable?
	# 	end 
	# end 

end
