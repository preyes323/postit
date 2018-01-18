class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.integer :voteable_id
      t.string  :voteable_type

      t.timestamps
    end

    add_index :votes, %i[user_id voteable_type voteable_id], unique: true
  end
end
