class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :content
      t.integer :order
      t.boolean :done

      t.timestamps
    end
  end
end
