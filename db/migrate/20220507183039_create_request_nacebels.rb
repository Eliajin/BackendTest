class CreateRequestNacebels < ActiveRecord::Migration[7.0]
  def change
    create_table :request_nacebels do |t|
      t.references :request, null: false, foreign_key: true
      t.references :nacebel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
