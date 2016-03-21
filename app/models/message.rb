class Message < ActiveRecord::Base
	belongs_to :conversation
	belongs_to :user

	validates_presence_of :body, :conversation_id, :user_id

	after_create :notify_message_received

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

		def on_change
			Message.connection.execute "LISTEN messages"
			loop do
				Message.connection.raw_connection.wait_for_notify do |event, pid, message|
					yield message
				end
			end
		ensure
			Message.connection.execute "UNLISTEN messages"
		end
	end

	private

	def notify_message_received
		Message.connection.execute "NOTIFY messages, '#{self.id}'"
	end
end
