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

	# Custom file input tag with wrapper to suit materialize UI
	def file_field_tag_v2(title, name, options = {})
		<<-html
			<div class="input-field file-field">
				<div class="btn">
					<span>#{title}</span>
					#{if options[:form_builder] then options[:form_builder].file_field(name) else file_field_tag(name) end}
				</div>
				<div class="file-path-wrapper">
					<input class="file-path" type="text" readonly>
				</div>
			</div>
		html
		.html_safe
	end

	# Get HH:MM:SS format from seconds
	def hms(seconds)
		Time.at(seconds).utc.strftime "%H:%M:%S"
	end

	# Returns class name 'yay-hide' or '', according to yaybar toggle state
	def yaybar_state_class
		cookies.permanent[:yaybar_hidden] == 'true' ? 'yay-hide' : ''
	end

end
