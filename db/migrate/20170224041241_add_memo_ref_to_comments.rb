class AddMemoRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :memo, foreign_key: true
  end
end
