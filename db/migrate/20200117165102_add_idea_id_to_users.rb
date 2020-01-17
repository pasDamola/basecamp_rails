class AddIdeaIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :idea_id, :integer
  end
end
