# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create users
5.times do |i|
    user = User.create!(name: "User #{i+1}", photo: "https://picsum.photos/200", 
                        bio: "I'm a user in this app.", posts_counter: 0)
  
    # Create posts for the current user
    rand(1..5).times do |j|
      post = Post.create!(title: "Post #{j+1} by #{user.name}",
                          text: "This is post #{j+1} by #{user.name}.",
                          comments_counter: 0, likes_counter: 0,
                          author_id: user.id)
            
      # Update counters for the current post
      Post.update_counters(post.id, comments_counter: post.comments.count, likes_counter: post.likes.count)
    end
  
    # Update counters for the current user
    User.update_counters(user.id, posts_counter: user.posts.count)
  end