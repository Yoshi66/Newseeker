class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

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
    puts "PPPPPPPPPPPPPPPPPPPPPPPP"
    puts params
    puts "PPPPPPPPPPPPPPPPPPPPPPP"
    redirect_to users_registrations(params)
    # respond_to do |format|
    #   format.html {render second_view, passing_data: params}
    #   puts 'DDDDDDDDDDDDDDDDDDDDDDDDDD'
    #   format.js
    # end
    # redirect_to users_registrations_second_view_path()
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
  #   super
  # end

  # PUT /resource
  # def update
  #   super
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
