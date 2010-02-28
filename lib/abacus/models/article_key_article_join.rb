module Abacus
  class ArticleKeyArticleJoin < Abacus
  
    belongs_to :article,        :class_name => "Abacus::Article"
    belongs_to :article_key,    :class_name => "Abacus::ArticleKey"
  
  end
end