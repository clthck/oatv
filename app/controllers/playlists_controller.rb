class PlaylistsController < ApplicationController
	# GET
	def index
		add_breadcrumb "Playlists", :playlists_path
		playlists = current_user.club.playlists.order(:id)
		respond_to do |format|
			format.html
			format.json { render json: { data: playlists } }
		end
	end

	# POST
	# Handles create, update and remove action of DataTables Editor
	def datatables_editor_cud
		json_data = Playlist.datatables_editor_cud(request.POST[:action], params[:data].to_a, current_user.club)
		respond_to do |format|
			format.json { render json: json_data }
		end
	end
end
