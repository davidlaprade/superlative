class Title < ActiveRecord::Base

has_many :favorites
has_many :votes, through: :favorites, source: :user

validates_uniqueness_of :content



end
