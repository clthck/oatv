module ApplicationHelper

	def method_missing(method_name, *args)
		# define dynamic method :flash_xxxx
		match = method_name.to_s.match /^flash_(\w+)/
		if match
			self.class.class_eval do
				define_method(method_name) do |*args|
					if args.count > 0 && args[0] == :toast
						render partial: "shared/flash/toast", locals: {message: eval(match[1])}
					else
						render partial: "shared/flash/#{match[1]}"
					end
				end
			end
			send method_name
		else
			raise "Method #{method_name} is missing"
		end
	end

	# Get page title
	def page_title(default = nil)
		content_for(:page_title) || default
	end

end
