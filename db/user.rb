class User < ActiveRecord::Base

    has_many :finstagram_posts
    has_many :comments
    has_many :Likes

end