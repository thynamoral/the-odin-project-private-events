class AddLocationAndCreatorToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :location, :string
    add_reference :events, :creator, foreign_key: { to_table: :users }, null: false
  end
end
