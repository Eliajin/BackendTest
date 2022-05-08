# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

p 'begin'

filename = 'C:\Users\abrichard\Documents\Yago_test\BackendTest\AssuranceApp\public\NACEBEL_2008.csv'
options = {:col_sep => ';', :force_utf8 => true} # We don t need theses options
n = SmarterCSV.process(filename, options) do |array|
        # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
        # when chunking is not enabled, there is only one hash in each array
        # Allow Nacebel to create every row in DB
        array.first["level"] = array.first.delete(:level_nr)
        array.first["code"] = array.first.delete(:code)
        array.first["parentCode"] = array.first.delete(:parent_code)
        array.first["labelNL"] = array.first.delete(:label_nl)
        array.first["labelFR"] = array.first.delete(:label_fr)
        array.first["labelDE"] = array.first.delete(:label_de)
        array.first["labelEN"] = array.first.delete(:label_en)
        Nacebel.create( array.first )
end

p '--after process--'
p '--ending--'