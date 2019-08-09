# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'pry'
require 'faker'
City.destroy_all
User.destroy_all
Gossip.destroy_all
JoinTableGossipTag.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
JoinTableMessageRecipient.destroy_all
Comment.destroy_all

10.times do
  City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Quote.matz, email: Faker::Internet.email, age: rand(15..40), city: City.all.sample, password: Faker::Internet.password(min_length: 6),)
end

20.times do
  Gossip.create(title: Faker::Quote.singular_siegler, content: Faker::Quote.matz, user: User.all.sample)
end

10.times do
  Tag.create(title: Faker::TvShows::SouthPark.character)
end

Gossip.all.each do |gossip|
  JoinTableGossipTag.create(gossip: gossip, tag: Tag.all.sample)
end

80.times do
  JoinTableGossipTag.create(gossip: Gossip.all.sample, tag: Tag.all.sample)
end

20.times do # Permet d'envoyer un message depuis un sender à 1 ou plusieurs recipients, en évitant de s'envoyer le message à soi-même et d'envoyer le message plusieurs fois au même recipient
  senders = User.all.to_a # On récupère tous les users dans un array
  sender = senders.sample # On récupère un user au hasard
  senders.delete(sender) # On enlève de l'array de tous les user le sender
  content = Faker::Lorem.sentence
  nb_recipients = rand(1..senders.length) # On génère un nombre de recipients au hasard
  nb_recipients.times do
    recipient = senders.sample # On récupère un recipient depuis l'array
    senders.delete(recipient) # On le remove de l'array
    JoinTableMessageRecipient.create(private_message: PrivateMessage.create(sender: sender, content: content), recipient: recipient)
  end
end

20.times do
  Comment.create(user: User.all.sample, commentable: Gossip.all.sample, content: Faker::Quote.matz)
end

40.times do # Au hasard on like soit un gossip soit un comment
    if rand(0..1) == 0
      thing = Gossip.all.sample
    else
      thing = Comment.all.sample
    end
  Like.create(user: User.all.sample, likeable: thing)
end

20.times do # Au hasard on comment soit un gossip soit un comment
    if rand(0..1) == 0
      thing = Gossip.all.sample
    else
      thing = Comment.all.sample
    end
    Comment.create(user: User.all.sample, commentable: thing, content: Faker::Quote.matz)
end
