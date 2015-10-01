class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :articles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable
  has_attached_file :profile_photo,:styles => {
                        :thumb  => "90x60",
                        :medium => "408x189",
                        :square => "100x100",
                        :large => "815x378",},
  :url  => "/assets/arts/:id/:style/:basename.:extension", # 画像保存先のURL先
  :path => "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension" # サーバ上の画像保存先パス
  validates_attachment :profile_photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  # ## Validation
  validates_attachment :profile_photo,
       presence: true,  # ファイルの存在チェック
       less_than: 5.megabytes # ファイルサイズのチェック
  before_validation :insert_profile_photo
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        name: auth.info.name,
        email: User.get_email(auth),
        profile_photo:auth.info.image,
        password: Devise.friendly_token[4, 30])
    end
    user
  end

  private
    def self.get_email(auth)
      email = auth.info.email
      email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
      email
    end

    def insert_profile_photo
      # p self
      # logger.debug "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      # self.profile_photo = "app/assets/images/DSCF3434.jpg"
      # puts self.profile_photo
      # if self.profile_photo = "/profile_photos/original/missing.png"
      #   logger.debug "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
      #   return self.profile_photo = "DSCF3434.jpg"
      # else
      #   logger.debug "ccccccccccccccccccccccccccccccccccccc"
      #   return self.profile_photo
      # end
    end
end
