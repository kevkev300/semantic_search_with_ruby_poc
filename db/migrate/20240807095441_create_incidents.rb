class CreateIncidents < ActiveRecord::Migration[7.1]
  def change
    create_table :incidents do |t|
      t.string :name
      t.text :description
      t.text :resolution
      t.text :summary
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end
