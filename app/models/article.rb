require 'open-uri'

class Article < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo,:styles => {
                        :thumb  => "90x60",
                        :medium => "408x189",
                        :large => "815x378"},
  :url  => "/assets/arts/:id/:style/:basename.:extension", # 画像保存先のURL先
  :path => "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension" # サーバ上の画像保存先パス
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  # ## Validation
  validates_attachment :photo,
       presence: true,  # ファイルの存在チェック
       less_than: 5.megabytes # ファイルサイズのチェック
  validates :url, presence: true
  before_validation :get_image_from_link

  private
    def get_image_from_link
      page = MetaInspector.new(url)
      return unless page.images.best.present?
      puts "AAAAAAAAAAAAAAA"
      self.title = page.best_title
      self.content = page.description
      self.photo = page.images.best
      puts "AAAAAAAAAAAAAAAAA"
    end
end
