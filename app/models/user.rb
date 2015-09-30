class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
end
