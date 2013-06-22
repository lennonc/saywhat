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
  ["Kyle", "Moore", "kmmoore@stanford.edu", "password"],
  ["Lennon", "Chimbumu", "me@example.com", "password"]

]

speaker_list = [
  "Kyle Moore",
  "Ian Campbell"
]

user_list.each do |first_name, last_name, email, password|
  User.create(first_name: first_name, last_name: last_name, email: email, password: password)
end

speaker_list.each do |name|
  Speaker.create(:name => name)
end


quote_list.each do |user_id, quote, speaker, date_of_quote|
    Quote.create(user_id: user_id, quote: quote, speaker_id: speaker_list.index(speaker) + 1, date_of_quote: date_of_quote)
end
