module Abacus
  class Abacus < ActiveRecord::Base

    self.abstract_class = true
    CONNECTION_STRING = CONFIG_FILE['database']
      
    establish_connection CONNECTION_STRING
  
    class << self
    
      # Import a xdxf file inside the database
      def import(filename, options = {:verbose=>false})
        doc = Nokogiri::XML::Document.parse(File.read(filename))
      
        Abacus.transaction do 
       
          # Info regarding the dict type
          dic = Dictionary.create!(
            :full_name => doc.css('full_name').first.content,
            :lang_from => doc.css('xdxf').first.attributes['lang_from'].value,
            :lang_to   => doc.css('xdxf').first.attributes['lang_to'].value
          )
        
          # Articles
          doc.css('ar').each do |ar|
            (ardb = dic.articles.create!(
              :raw_text => ar.to_s
            )).article_keys = ar.css('k').map{ |k|
              ArticleKey.find_or_create_by_the_key(
                :the_key  => k.xpath('text()').to_s,
                :raw_text => k.to_s
              )
            }
            puts "<< #{ardb.article_keys.map{|ak| ak.the_key}.join(",")}"  if options[:verbose]
          end
                  
        end
      
      end
    end
  end
end