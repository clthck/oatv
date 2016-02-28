class Users::RegistrationsController < Devise::RegistrationsController
  skip_load_and_authorize_resource
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  layout "bubble", except: [:edit, :update, :add_coach, :add_player]

  before_action :check_club_payment_status, only: [:add_coach, :add_player]

  # GET /resource/sign_up
  # Sign up form for club admin user
  def new
    build_resource club: Club.new
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  # POST /resource
  # Create a club admin user
  def create
    params[:user][:club_attributes][:active] = false
    params[:user][:role_id] = Role.find_by(name: 'club_admin').id
    super
  end

  # GET /resource/edit
  def edit
    add_breadcrumb "Edit My Profile", :edit_user_registration_path
    @user = current_user
    @user.build_profile if @user.profile.nil?
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # GET /users/add_coach
  def add_coach
    authorize! :add, :coach
    add_breadcrumb "Add Coach", :users_add_coach_path
    set_minimum_password_length
    @user = User.new
  end

  # POST /users/add_coach
  def create_coach
    authorize! :add, :coach
    params[:user][:role_id] = Role.find_by(name: 'coach').id
    params[:user][:club_id] = current_user.club_id
    @user = User.new params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :club_id)
    @user.save
    if @user.persisted?
      flash[:notice] = "A confirmation email has been sent to #{@user.email}."
    end
    render :add_coach, layout: 'application'
  end

  # GET /users/add_player
  def add_player
    authorize! :add, :player
    add_breadcrumb "Add Player", :users_add_player_path
    set_minimum_password_length
    @user = User.new
  end

  # POST /users/add_player
  def create_player
    authorize! :add, :player
    params[:user][:role_id] = Role.find_by(name: 'player').id
    params[:user][:club_id] = current_user.club_id
    @user = User.new params.require(:user).permit(:email, :password, :password_confirmation, :role_id, :club_id)
    @user.save
    if @user.persisted?
      flash[:notice] = "A confirmation email has been sent to #{@user.email}."
    end
    render :add_player, layout: 'application'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    # super(resource)
    new_user_session_path
  end

  private

  def check_club_payment_status
    unless current_user.club.active
      if can? :manage, Club
        flash[:notice] = "You need to choose subscription plan first."
        redirect_to choose_subscription_plan_clubs_path
      else
        flash[:notice] = "Your club's subscription plan is not activated. Please contact your club administrator."
        redirect_to :back
      end
    end
  end
end
