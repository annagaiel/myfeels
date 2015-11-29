class CreateEmotions < ActiveRecord::Migration
  def change
    create_table :emotions do |t|
      t.string :name
      t.boolean :is_positive

      t.timestamps null: false
    end

    create_table :cups_emotions do |t|
      t.references :emotion
      t.references :cup
    end
  end
end
