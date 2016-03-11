class Message < ActiveRecord::Base
	belongs_to :conversation
	belongs_to :user

	validates_presence_of :body, :conversation_id, :user_id

	class << self
		def in_order
			order created_at: :asc
		end

		def recent(n)
			in_order.endmost(n)
		end

		def endmost(n)
			all.only(:order).from(all.reverse_order.limit(n), table_name)
		end
	end
end
