class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :spray_paint_tags do |t|
      t.string :name
    end

    add_index :spray_paint_tags, :name, :unqiue => true

    create_table :spray_paint_taggings do |t|
      t.references :tag
      t.references :taggable, :polymorphic => true
      t.datetime :created_at
    end

    add_index :spray_paint_taggings, :tag_id
    add_index :spray_paint_taggings, [:taggable_id, :taggable_type]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
