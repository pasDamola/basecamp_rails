class CreateJoinTableUsersIdeas < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :ideas do |t|
       t.index [:user_id, :idea_id]
       t.index [:idea_id, :user_id]
    end
  end
end
