class CreateNacebels < ActiveRecord::Migration[7.0]
  def change
    create_table :nacebels do |t|
      t.integer :level
      t.string :code
      t.string :parentCode
      t.string :labelNL
      t.string :labelFR
      t.string :labelDE
      t.string :labelEN

      t.timestamps
    end
  end
end
