class CreateCups < ActiveRecord::Migration
  def change
    create_table :cups do |t|
      t.references :user

      t.timestamps null: false
    end
  end
end
