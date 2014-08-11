class AddAccessCodeToUser < ActiveRecord::Migration
  def change
  	  add_column :users, :access_code, :string, default: nil
  	  
  	  # See http://guides.rubyonrails.org/migrations.html to explain why this is here
  	  User.reset_column_information
  	  # Changes all the previously created rows in the database
  	  User.update_all(access_code: 'siboston')
  end
end
