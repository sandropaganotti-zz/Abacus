module Abacus
  class HerigoneNumber < Abacus
  
    validates_presence_of   :system, :number
    validates_uniqueness_of :number, :scope=>:system

    has_many   :article_key_herigone_number_joins, :dependent => :destroy, :class_name=>"Abacus::ArticleKeyHerigoneNumberJoin"
    has_many   :article_keys, :through=>:article_key_herigone_number_joins,:class_name=>"Abacus::ArticleKey"
  
  end
end