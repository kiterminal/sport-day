class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :code
      t.string :first_name
      t.string :last_name
      t.string :color

      t.timestamps
    end
  end
end
