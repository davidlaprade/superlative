class Favorite < ActiveRecord::Base

belongs_to :user
belongs_to :title


# A user should not be able to favorite multiple titles for a given user
# 	See http://stackoverflow.com/questions/1486020/validates-uniqueness-of-scope-on-other-table
# 	See http://stackoverflow.com/questions/9033797/how-to-specify-conditions-on-joined-tables-in-rails
# validates_each :user_id do |record, attr, value|
#   if Favorite.joins(:title).where(:titles => {:user_id => value}).present?
#     record.errors.add attr, 'Can only favorite one superlative per person!'
#   end
# end

end
