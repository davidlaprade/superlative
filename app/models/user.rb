class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


# See http://stackoverflow.com/questions/2650897/in-rails-how-should-i-implement-a-status-field-for-a-tasks-app-integer-or-enu#2651261
ROLES = ['patron', 'admin', 'guest']
validates_inclusion_of :role, :in => ROLES,
          :message => "{{value}} must be in #{ROLES.join ','}"


  mount_uploader :photo, PhotoUploader

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, message: 'must be unique'
  validates :photo, presence: true
  validates :track, presence: true
  # see root/app/models/accesscode_validator to see how this works
  validates_with AccesscodeValidator
  



  # validate :check_access_code

  # # see http://stackoverflow.com/questions/2273122/how-do-i-validate-that-two-values-do-not-equal-each-other-in-a-rails-model
  # def check_access_code
  #   errors.add(:access_code, "incorrect access code") if access_code != "siboston"
  # end

  has_many :favorites, dependent: :destroy
  has_many :favorite_superlatives, through: :favorites, source: :title
  has_many :titles, dependent: :destroy

# call on user object, returns ordered array of arrays [n,m,o] where m is the content of one of the user's superlatives/titles
# n is the corresponding number of votes/favorites that superlative has for that user, and o is the superlative/title id
  def ranked_superlatives
    result_array = []
    self.titles.each do |title|
      result_array << [title.votes.count, title.content, title.id]
    end
    # for how sort works http://stackoverflow.com/questions/2637419/how-does-arraysort-work-when-a-block-is-passed
    result_array = result_array.sort { |x, y| y[0] <=> x[0] }
    return result_array
  end

  # called on user object; returns number of max votes on user's top-voted superlative
  def max_votes
    if self.ranked_superlatives.present?
      return self.ranked_superlatives[0][0]
    else
      return 0
    end
  end

  # call on user object, returns an array of superlative contents that are tied for the most votes
  def top_superlatives
    if !self.ranked_superlatives.empty?
      ranked_superlatives = self.ranked_superlatives
      max_votes = ranked_superlatives[0][0]
      top_superlatives = []
      ranked_superlatives.each do |array|
        if array[0] == max_votes
          top_superlatives << array[1]
        end
      end
      return top_superlatives
    else
      return ["No superlatives suggested yet!"]
    end
  end

end


