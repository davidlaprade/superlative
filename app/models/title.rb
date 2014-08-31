class Title < ActiveRecord::Base

has_many :favorites
has_many :votes, through: :favorites, source: :user
belongs_to :user

validates_uniqueness_of :content, :message => "must be unique"
validates_presence_of :content, :message => "cannot be blank"

def user_title_was_suggested_for
	@user = User.find(self.user_id)
	return @user
end

end
