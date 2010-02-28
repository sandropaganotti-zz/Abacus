module Abacus
  class ArticleKey < Abacus
  
    validates_presence_of :the_key
    validates_uniqueness_of :the_key

    has_many   :article_key_article_joins, :dependent => :destroy,              :class_name=>"Abacus::ArticleKeyArticleJoin"
    has_many   :articles, :through=>:article_key_article_joins,                 :class_name=>"Abacus::Article"
    has_many   :article_key_herigone_number_joins, :dependent => :destroy,      :class_name=>"Abacus::ArticleKeyHerigoneNumberJoin"
    has_many   :herigone_numbers, :through=>:article_key_herigone_number_joins, :class_name=>"Abacus::HerigoneNumber"
  
  end
end