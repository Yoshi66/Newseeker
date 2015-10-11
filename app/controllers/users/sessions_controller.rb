class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
skip_before_filter :verify_authenticity_token, only: [:create]

  # GET /resource/sign_in
  def new
    @user = User.new
    puts 'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
    puts 'LLLLLLLLLLLLLLLLLLLLLLLLL'
    puts 'CCSSSSSSSSSSSSSSSSSSSS'
    respond_to do |format|
      format.html  {render :template => "devise/sessions/_new" }
      puts 'DDDDDDDeeeeeeeeeeeeeeDDDDDDD'
      format.js
    end
  end

  def create
    if request.xhr?
      opts = auth_options
      opts[:recall] = "#{controller_path}#xhr_failure"
      self.resource = warden.authenticate!(opts)
      sign_in(resource_name, resource)
      xhr_success
    else
      super
    end
  end

  def xhr_success
    render json: { result: true }
  end

  def xhr_failure
    render json: { result: false, errors: ["Login failed."] }
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
