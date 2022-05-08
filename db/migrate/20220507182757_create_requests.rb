class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :email
      t.string :phonenumber
      t.string :name
      t.string :surname
      t.string :address
      t.integer :annualRevenue
      t.string :enterpriseNumber
      t.string :legalName
      t.boolean :naturalPerson

      t.timestamps
    end
  end
end
