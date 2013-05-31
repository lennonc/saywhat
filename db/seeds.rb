# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

quote_list = [
  [ 1, "I could kill future me!", "Ian Campbell", Time.now ],
  [ 2, "That's the best thing you've said all day!", "Kyle Moore", Time.now ],
]

user_list = [
  ["Kyle", "Moore", "me@example.com"],
  ["Lennon", "Chimbumu", "me@example.com"]

]

user_list.each do |first_name, last_name, email|
  User.create(first_name: first_name, last_name: last_name, email: email)
end

quote_list.each do |user_id, quote, speaker, date_of_quote|
    Quote.create(user_id: user_id, quote: quote, speaker: speaker, date_of_quote: date_of_quote)
end
