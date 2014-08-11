class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


# See http://stackoverflow.com/questions/2650897/in-rails-how-should-i-implement-a-status-field-for-a-tasks-app-integer-or-enu#2651261
ROLES = ['patron', 'admin']
validates_inclusion_of :role, :in => ROLES,
          :message => "{{value}} must be in #{ROLES.join ','}"


  mount_uploader :photo, PhotoUploader

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, message: 'must be unique'
  validates :photo, presence: true
  validates :track, presence: true

  has_many :favorites, dependent: :destroy
  has_many :favorite_superlatives, through: :favorites, source: :title
  has_many :titles, dependent: :destroy

  
  # call on user object, returns array [n,m] where n is the top-voted superlative for the user, 
  # and m is the number of votes that superlative has
  def top_rated_superlative
    votes_to_beat = 0
    top_title = ""
    self.titles.each do |title|
      if title.votes.count > votes_to_beat
        votes_to_beat = title.votes.count
        top_title = title.content
      end
    end
    return [top_title, votes_to_beat]
  end

# call on user object, returns array of arrays [n,m] where m is the content of one of the user's superlatives
# and n is the corresponding number of votes/favorites that superlative has for that user
  def ranked_superlatives
    store_array = []
    self.titles.each do |title|
      store_array << [title.votes.count, title.content]
    end
    result_array = result_array.sort_by{0}
    return result_array
  end

end
