class CreateTestimonials < ActiveRecord::Migration[7.2]
  def change
    create_table :testimonials do |t|
      t.text :text
      t.boolean :approved
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
