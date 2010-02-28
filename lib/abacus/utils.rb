
# TOOLS TO MANAGE Abacus DATABASE
module Abacus

  class MigrationUtilities
  
    class << self    
    
      # It creates the database and execute the migrations 
      def create_database!
        
          FileUtils.mkdir_p(File.split(Abacus::CONNECTION_STRING['database']).first)
        
          ActiveRecord::Base.establish_connection Abacus::CONNECTION_STRING
          ActiveRecord::Base.connection

          ActiveRecord::Schema.define do
            create_table :dictionaries do |t|
              t.column :full_name, :string
              t.column :lang_from, :string
              t.column :lang_to,   :string
              t.column :description, :text
            end

            create_table :articles do |t|
              t.column :dictionary_id, :integer
              t.column :raw_text,      :text
            end            

            create_table :article_key_article_joins do |t|
              t.column :article_id,     :integer
              t.column :article_key_id, :integer
            end

            create_table :article_keys do |t|
              t.column :the_key,     :string
              t.column :raw_text,    :text
            end
            
            create_table :herigone_numbers do |t|
              t.column :system,      :string
              t.column :number,      :integer, :limit=>8
            end

            create_table :article_key_herigone_number_joins do |t|
              t.column :article_key_id,             :integer
              t.column :herigone_number_id,     :integer
            end

            add_index :herigone_numbers, :number
            add_index :article_keys,     :the_key
          end
      end
  
    end
  end
end