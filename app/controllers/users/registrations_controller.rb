class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
skip_before_filter :verify_authenticity_token, only: [:create]

  # GET /resource/sign_up
  def new
    @user = User.new
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
    puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
    respond_to do |format|
      format.html  {render :template => "devise/registrations/_new" }
      puts 'DDDDDDDeeeeeeeeeeeeeeDDDDDDD'
      format.js
    end
  end

  def detail_info
    redirect_to users_registrations(params)
    # respond_to do |format|
    #   format.html {render second_view, passing_data: params}
    #   puts 'DDDDDDDDDDDDDDDDDDDDDDDDDD'
    #   format.js
    # end
    # redirect_to users_registrations_second_view_path()
  end


  def update
    @user = User.find(current_user.id)
    puts @user.name
    if @user.update_attributes(params[:user].permit(:name,:email, :company,:position,:introduction, :profile_photo))
      puts @user.name
      # Sign in the user bypassing validation in case his password changed
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def create
    build_resource(sign_up_params)
    puts sign_up_params
    puts sign_up_params
    puts sign_up_params
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
        puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
        return render :json => {:success => true}
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        puts 'BBBBBBBBB'
        puts 'BBBBBBBBB'
        return render :json => {:success => true}
      end
    else
      puts resource.errors.full_messages
      clean_up_passwords resource
      return render :json => {:success => false}
    end
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # def second_view
  #   puts "second view"
  #   puts params
  #   puts "second view"
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
  #   puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
  #   puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
  #   puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
  # end

  # PUT /resource
  # def update
  #   puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
  #   puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
  #   puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
  #   puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
  #   puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
  #   redirect_to root_path
  # end

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

  # protected
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
