require 'faker'

User.destroy_all
Category.destroy_all
Goal.destroy_all
Day.destroy_all

# categories seed data
environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")

def seed_image(file_name)
  File.join(Rails.root, "/app/assets/images/seed/#{file_name}.png")
end

categories = ["Health", "Productivity", "Finances", "Personal Growth", "Fitness"]

categories.each do |category|
  Category.create({ title: category,
                    badge_url: seed_image(category.downcase)})
end

# users seed data
10.times do
  username = Faker::Internet.user_name
  User.create({ username: username,
                email: Faker::Internet.free_email(username),
                password: "password"})
end

#goals seed data
users = User.all
categories = Category.all

40.times do
  goal = Goal.create({ title: Faker::Hipster.sentence,
                completed: [true, false].sample,
                archived: true,
                category: categories.sample,
                user: users.sample})

  (0..21).to_a.sample.times do
    goal.days.create({status: "achieved"})
  end
end

users.each do |user|
  goal = Goal.create({ title: Faker::Hipster.sentence,
                completed: false,
                archived: false,
                category: categories.sample,
                user: user})

   (0..21).to_a.sample.times do
      goal.days.create({status: "achieved"})
    end
end
