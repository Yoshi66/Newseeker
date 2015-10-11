require 'open-uri'

class Article < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attached_file :photo,:styles => {
                        :thumb  => "650x320>",
                        :medium => "400x190#",
                        :square => "650x320#",
                        :large => "800x380#",},
                        :use_timestamp => false,
  :url  => "/assets/arts/:id/:style/:basename.:extension", # 画像保存先のURL先
  :path => "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension" # サーバ上の画像保存先パス
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
        presence: true,  # ファイルの存在チェック
       less_than: 5.megabytes
  # do_not_validate_attachment_file_type :photo
  # ## Validation
        # ファイルサイズのチェック
  validates :url, presence: true
  before_validation :get_image_from_link
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/]



  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

    def get_image_from_link
      if url.starts_with?("http")
        page = MetaInspector.new(url)
        return unless page.images.best.present?
        p page.images.best
        self.title = page.best_title
        # p page.best_title
        self.title = page.title
        # p page.title
        p "AAAAAAAAAAAAAAAAAAAAAAAAAA"
        # puts page.head_links
        # puts page.meta_tags
        p "BBBBBBBBBBBBBBBB"
        self.content = page.description
        self.photo = URI.parse(page.images.best)
        # self.asset = URI.parse("http://s3.amazonaws.com/blah/blah/blah.jpg")
      end
    end
end
