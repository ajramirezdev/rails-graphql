class UpdateUsersTable < ActiveRecord::Migration[8.0]
  def change
    # Remove the `name` column
    remove_column :users, :name, :string

    # Add missing columns
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :mobile_number, :string, null: false
    add_column :users, :birthdate, :date, null: false
    add_column :users, :gender, :string, null: false
    add_column :users, :sexual_orientation, :string, null: false
    add_column :users, :gender_interest, :string, null: false
    add_column :users, :country, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :school, :string
    add_column :users, :bio, :text, null: false
    add_column :users, :images, :jsonb, default: [], null: false

    change_column :users, :email, :string, null: false
    add_index :users, :email, unique: true
  end
end
