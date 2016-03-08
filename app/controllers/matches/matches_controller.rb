class Matches::MatchesController < ApplicationController
	before_action :get_match_categories, only: [:index, :show]
	# GET
	def index
		add_breadcrumb "Matches", :matches_path
		matches = current_user.club.matches.order(date: :desc)
		respond_to do |format|
			format.html
			format.json { render json: { data: 
				matches.as_json(include: :category)
				} }
		end
	end

	# GET
	def show
		add_breadcrumb "Matches", :matches_path
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = Match.datatables_editor_cud(request.POST[:action], params[:data].to_a, current_user)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end

	# GET
	def stats
		add_breadcrumb "Match", @match
		add_breadcrumb "Stats", stats_match_path(@match)
		@match.build_match_stat if @match.match_stat.nil?
		render layout: false
	end

	# GET
	def edit_stats
		add_breadcrumb "Match", @match
		add_breadcrumb "Stats", edit_stats_match_path(@match)
		@match.build_match_stat if @match.match_stat.nil?
	end

	# PATCH
	def update
		@match.update match_params
		if @match.save
			flash[:notice] = "Match stats updated successfully."
		else
			flash[:alert] = "Match stats could not be updated!"
		end
		redirect_to :back
	end

	private

	def get_match_categories
		@match_categories = MatchCategory.all.order(:name).collect do |cat|
			{ value: cat.id, label: cat.name }
		end
	end

	def match_params
		params.require(:match).permit(match_stat_attributes: [
			:id, :goals_h, :goals_a, :total_shots_h, :total_shots_a, :shots_on_target_h, :shots_on_target_a, :completed_passes_h, :completed_passes_a, :passing_accuracy_h, :passing_accuracy_a, :possession_h, :corners_h, :corners_a, :offsides_h, :offsides_a, :fouls_conceded_h, :fouls_conceded_a
			])
	end
end
