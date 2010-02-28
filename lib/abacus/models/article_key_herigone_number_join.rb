module Abacus
  class ArticleKeyHerigoneNumberJoin < Abacus
  
    belongs_to :herigone_number, :class_name => "Abacus::HerigoneNumber"
    belongs_to :article_key,     :class_name => "Abacus::ArticleKey"
  
  end
end

