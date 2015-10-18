class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.text :phrase
      t.string :author
      t.string :background
      t.string :foreground
      t.string :font

      t.timestamps
    end
  end
end
