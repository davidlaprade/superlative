class Title < ActiveRecord::Base

has_many :favorites
has_many :votes, through: :favorites, source: :user

end
