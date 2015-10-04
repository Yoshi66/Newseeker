require 'open-uri'

class Article < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attached_file :photo,:styles => {
                        :thumb  => "90x60",
                        :medium => "600x189#",
                        :square => "100x100",
                        :large => "815x378#",},
  :url  => "/assets/arts/:id/:style/:basename.:extension", # 画像保存先のURL先
  :path => "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension" # サーバ上の画像保存先パス
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  # ## Validation
  validates_attachment :photo,
       presence: true,  # ファイルの存在チェック
       less_than: 5.megabytes # ファイルサイズのチェック
  validates :url, presence: true
  before_validation :get_image_from_link



  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

    def get_image_from_link
      page = MetaInspector.new(url)
      return unless page.images.best.present?
      self.title = page.best_title
      p page.best_title
      self.title = page.title
      p page.title
      p "AAAAAAAAAAAAAAAAAAAAAAAAAA"
      self.content = page.description
      self.photo = page.images.best
    end
end
