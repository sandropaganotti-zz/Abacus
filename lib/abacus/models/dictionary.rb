module Abacus
  class Dictionary < Abacus
  
    validates_presence_of :lang_from, :lang_to, :full_name
    has_many :articles, :dependent => :destroy, :class_name=>"Abacus::Article"
  
  end
end