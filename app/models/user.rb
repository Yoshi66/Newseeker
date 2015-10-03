class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :articles, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

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
  validates_attachment :profile_photo,
       presence: true,  # ファイルの存在チェック
       less_than: 5.megabytes # ファイルサイズのチェック

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

  def feed
    Article.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end


  private
    def self.get_email(auth)
      email = auth.info.email
      email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
      email
    end
end
