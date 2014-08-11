# See section 2.12 of http://guides.rubyonrails.org/active_record_validations.html
# See the answer: http://stackoverflow.com/questions/15001351/rails-where-to-place-your-activemodelvalidators
# This has to be located in the model and named ACCESSCODE_validator.rb for it to work, don't add any underscores
class AccesscodeValidator < ActiveModel::Validator
  def validate(user)
    if user.access_code != "siboston"
      user.errors[:base] << "Incorrect access code"
    end
  end
end