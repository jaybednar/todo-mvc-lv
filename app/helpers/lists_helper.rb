module ListsHelper

	def main_placeholder(list)
		list.errors.full_messages_for(:name).first || "Enter List Name"
	end 
	
end
