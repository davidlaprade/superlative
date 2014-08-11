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



# call on user object, returns array of arrays [n,m,o] where m is the content of one of the user's superlatives
# n is the corresponding number of votes/favorites that superlative has for that user
# o is the title id
  def ranked_superlatives
    result_array = []
    self.titles.each do |title|
      result_array << [title.votes.count, title.content, title.id]
    end
    # for how sort works http://stackoverflow.com/questions/2637419/how-does-arraysort-work-when-a-block-is-passed
    result_array = result_array.sort { |x, y| y[0] <=> x[0] }
    return result_array
  end

end
