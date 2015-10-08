namespace :db do
  desc "fill"
  task populate: :environment do
    User.create!(name:"Yoshik",
                 email: "yoshiki.mc@gmail.com",
                 password:"11112222",
                 password_confirmation:"11112222",
                 profile_photo:File.open("app/assets/images/DSCF3434.jpg"))
    2.times do |n|
      name = "#{n}"
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      url = "https://www.washingtonpost.com/world/national-security/russias-syria-intervention-may-force-choice-on-obama-act-or-yield/2015/10/07/a88f9996-6d16-11e5-9bfe-e59f5e244f92_story.html"
      user = User.create(name:name,
                  email:email,
                  password:password,
                  password_confirmation:password,
                  profile_photo:File.open("app/assets/images/DSCF3434.jpg"))
      article = user.articles.new(url: url)
      article.get_image_from_link
      article.save
      end
    # 5.times do |n|
    #   current_user = User.find(id: n+1)
    #   @article = Article.find(id:n+1)
    #   @comment = @article.comments.create(comment:"this is #{n+1}")
    #   @comment.user_id = current_user.id
    #   @comment.
    # end
  end
end

# namespace :db do
#   desc "Fill database with sample data"
#   task populate: :environment do
#     User.create!(name: "Example User",
#                  email: "example@railstutorial.jp",
#                  password: "foobar",
#                  password_confirmation: "foobar")
#     99.times do |n|
#       name  = Faker::Name.name
#       email = "example-#{n+1}@railstutorial.jp"
#       password  = "password"
#       User.create!(name: name,
#                    email: email,
#                    password: password,
#                    password_confirmation: password)
#     end
#   end
# end