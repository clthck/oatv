module ApplicationHelper

	def method_missing(method_name, *args)
		# define dynamic method :flash_xxxx and :flash_xxxx_as_toast
		match = method_name.to_s.match /^flash_(?:((\w+)_as_toast)|(\w+))$/
		if match
			self.class.class_eval do
				define_method(method_name) do
					if match[3]
						# :flash_xxxx
						render partial: "shared/flash/#{match[3]}"
					else
						# :flash_xxxx_as_toast
						render partial: "shared/flash/toast", locals: {message: eval(match[2])}
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
