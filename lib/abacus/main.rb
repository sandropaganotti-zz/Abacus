# if (Object.const_get("ABACUS_CONFIG_FILEPATH") rescue true)  
#   ABACUS_CONFIG_FILEPATH = File.join(File.dirname(__FILE__),'..','config.yml') 
# end
# puts ABACUS_CONFIG_FILEPATH
Object.const_get("ABACUS_CONFIG_FILEPATH") rescue begin
  ABACUS_CONFIG_FILEPATH = File.join(File.dirname(__FILE__),'..','config.yml')
end

module Abacus
  CONFIG_FILE = YAML::load(ERB.new(IO.read(ABACUS_CONFIG_FILEPATH)).result)
end

require File.join(File.dirname(__FILE__), 'models','abacus')
require File.join(File.dirname(__FILE__), 'models','article')
require File.join(File.dirname(__FILE__), 'models','article_key')
require File.join(File.dirname(__FILE__), 'models','article_key_article_join')
require File.join(File.dirname(__FILE__), 'models','dictionary')
require File.join(File.dirname(__FILE__), 'models','article_key_herigone_number_join')
require File.join(File.dirname(__FILE__), 'models','herigone_number')

require File.join(File.dirname(__FILE__), 'apps','herigone')

require File.join(File.dirname(__FILE__), 'utils')
