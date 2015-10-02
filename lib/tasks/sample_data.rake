namespace :db do
  desc "fill"
  task populate: :environment do
    User.create!(name:"Yoshik",
                 email: "yoshiki.mc@gmail.com",
                 password:"11112222",
                 password_confirmation:"11112222",
                 profile_photo:File.open("app/assets/images/DSCF3434.jpg"))
    5.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      User.create(name:name,
                  email:email,
                  password:password,
                  password_confirmation:password,
                  profile_photo:File.open("app/assets/images/DSCF3434.jpg"))
      end
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