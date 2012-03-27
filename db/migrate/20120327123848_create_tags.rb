class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :graffti_tags do |t|
      t.string :name
    end

    add_index :graffti_tags, :name, :unqiue => true

    create_table :graffti_taggings do |t|
      t.references :tag
      t.references :taggable, :polymorphic => true
      t.datetime :created_at
    end

    add_index :graffti_taggings, :tag_id
    add_index :graffti_taggings, [:taggable_id, :taggable_type]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
