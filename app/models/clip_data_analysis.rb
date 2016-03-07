require 'csv'

class ClipDataAnalysis
	# Constructor
	def initialize(video, file_name, content_type)
		@video = video
		@file_name = file_name
		@content_type = content_type
	end

	# Main analyze method
	def analyze(&block)
		case @content_type
		when 'text/csv'
			analyze_csv &block
		end
	end

	protected

	# Does CSV analysis
	def analyze_csv
		lines = CSV.read @file_name, col_sep: ';', skip_blanks: true, skip_lines: /Name;Time;Start;Stop/
		current_category = nil
		clips = []

		lines.each_with_index do |line, i|
			if m = line[0].match(/CATEGORY: (.+)/i)
				current_category = ClipCategory.where('lower(name) = ?', m[1].downcase).first || ClipCategory.create(name: m[1])
			else
				start = Moment.to_seconds(line[2], false)
				stop = Moment.to_seconds(line[3], false)
				next if start > @video.duration || stop == 0
				clips << Clip.new(video: @video, category: current_category, name: line[0], start: start, end: stop)
			end
			yield i.to_f / lines.count * 100 if block_given?
		end

		Clip.import clips
	end

end