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
						render partial: "shared/flash/toast", locals: { type: match[2].to_sym }
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

	# Get DOM element class to indicate whether current path equals the provided link path
	def cp(*paths)
		paths.each { |path| return "active" if current_page? path }
		nil
	end

	# Similar to `cp` method
	# Check current page against given array of {controller_name#action_name} patterns
	def cp_against_ca(*ca_patterns)
		ca_patterns.each do |pattern|
			ca = pattern.split '#'
			return "active" if ca[0] == controller_name and ca[1] == action_name
		end
		nil
	end

end
