class AddSenderIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender_id, :integer
    remove_column :messages, :recipient
  end
end
