# See section 2.12 of http://guides.rubyonrails.org/active_record_validations.html
# See the answer: http://stackoverflow.com/questions/15001351/rails-where-to-place-your-activemodelvalidators
class AccesscodeValidator < ActiveModel::Validator
  def validate(current_user)
    if current_user.access_code != "siboston"
      current_user.errors[:base] << "incorrect access code"
    end
  end
end