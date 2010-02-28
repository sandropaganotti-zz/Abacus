module Abacus
  class Article < Abacus
  
    validates_presence_of :dictionary_id, :raw_text

    belongs_to :dictionary
    has_many   :article_key_article_joins, :dependent => :destroy,  :class_name=>"Abacus::ArticleKeyArticleJoin"
    has_many   :article_keys, :through=>:article_key_article_joins, :class_name=>"Abacus::ArticleKey"
  
  end
end