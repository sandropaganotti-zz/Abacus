Abacus
======

Abacus is an xdxf parser and semantic toolset for Ruby.

Installation
------------

    gem install abacus

Abacus uses a sqllite database to store dictionary data; a config.yml file is used to determine the path of the database file, the default config.yml lies within the gem directory, inside the lib folder. You can point to a different config.yml file by setting the costant ABACUS\_CONFIG\_FILEPATH before requiring the gem. 

The default config.yml file set as database path an ".abacus\_db" folder within the current user home directory, for production environment you may, as stated before, set the ABACUS\_CONFIG\_FILEPATH costant before requiring the gem in order to use a different config.yml file.

Config.yml also store configuration parameters for some tools of the toolset but I'll talk about it later.

After installed Abacus you may want to import some dictionaries in order to start using the semantic tools, the first time you do that you have to execute from command line:

    abacus db:create 
    
in order to create the database file. (set ENV[ABACUS\_CONFIG\_FILEPATH] to specify a different config file). 

    ABACUS_CONFIG_FILEPATH=/where/you/want abacus db:create

Then use the import function to load xdxf dictionaries (you can choose from a broad selection from here: http://xdxf.revdanica.com/down/, I used this one: http://downloads.sourceforge.net/xdxf/comn\_sdict05\_eng\_eng\_main.tar.bz2); at the moment the parser is pretty naif and it supports only some tags, but the whole dictionary is already being stored as 'raw_data' during the import so with future releases there might be further improvements also over imported dictionaries. The syntax to import a dict file is:

    abacus db:xdxf:import filaname.xdxf
    
The import popolate the db tables with the contents of the dictionary file, multiple dictionaries can be added calling multiple times the above command. 

Navigate the dictionary
-----------------------

To navigate the dictionary do as following:

    >> require 'abacus'
    => true
    >> include Abacus
    => Object
    >> Dictionary.all
    => [#<Abacus::Dictionary id: 1, full_name: "English explanatory dictionary (main)", lang_from: "ENG", lang_to: "ENG", description: nil>]
    >> Dictionary.first.articles[1000..1002]
    => [#<Abacus::Article id: 1001, dictionary_id: 1, raw_text: "Camberwell Beauty\nn. a deep purple butterfly, Nymph...">, #<Abacus::Article id: 1002, dictionary_id: 1, raw_text: "Cambodian\nn. & adj. --n. 1 a a native or national o...">, #<Abacus::Article id: 1003, dictionary_id: 1, raw_text: "Cambrian\n\313\210k\303\246mbr\311\252\311\231n adj. & n. --adj. 1 Welsh. 2 ...">]
    >> Dictionary.first.articles.find(13000).article_keys
    => [#<Abacus::ArticleKey id: 13000, the_key: "decipher", raw_text: "decipher">]
    >> ArticleKey.find_by_the_key("ruby").articles.first
    => #<Abacus::Article id: 34912, dictionary_id: 1, raw_text: "ruby\n\313\210ru:b\311\252 n., adj., & v. --n. (pl. -ies) 1 a ra...">
    >> ArticleKey.find_by_the_key("ruby").articles.first.raw_text
    => "ruby\n\313\210ru:b\311\252 n., adj., & v. --n. (pl. -ies) 1 a rare precious stone consisting of corundum with a colour varying from deep crimson or purple to pale rose. 2 a glowing purple-tinged red colour. --adj. of this colour. --v.tr. (-ies, -ied) dye or tinge ruby-colour. \303\270ruby glass glass coloured with oxides of copper, iron, lead, tin, etc. ruby-tail a wasp, Chrysis ignita, with a ruby-coloured hinder part. ruby wedding the fortieth anniversary of a wedding. [ME f. OF rubi f. med.L rubinus (lapis) red (stone), rel. to L rubeus red]"
    
    
There are two main models, Article and ArticleKey, Article is the hub for all the article properties and it contains the raw text (attribute raw_text) taken from xml:

    XML FILE:
    <ar><k>ironic</k>
    <tr>aɪˈrɔnɪk</tr> adj. (also ironical) 1 using or displaying irony. 2 in the nature of irony. øøironically adv. [F ironique or LL ironicus f. Gk eironikos dissembling (as IRONY(1))]</ar>

    IRB:
    >> ArticleKey.find_by_the_key('ironic').articles[0].raw_text
    => "ironic\na\311\252\313\210r\311\224n\311\252k adj. (also ironical) 1 using or displaying irony. 2 in the nature of irony. \303\270\303\270ironically adv. [F ironique or LL ironicus f. Gk eironikos dissembling (as IRONY(1))]"
    
For each article there may be one or more article_keys, which contains the linguistic identifiers of the article itself. Each article key can in turn be related to more than one article but from different dictionaries. 


FIRST TOOL: HERIGONE MNEMONIC SYSTEM
------------------------------------

(detailed explaination of this technique on Wikipedia: http://en.wikipedia.org/wiki/Herigone%27s\_mnemonic_system) Within config.yml you can set a list of association between numbers and letters (the standard one is already written within the standard config file):

Here's a sample config.yml file (this also the default one):

    database:
      adapter: sqlite3
      database: <%=File.join(ENV['HOME'] || ENV['USERPROFILE'] || (Abacus::LIB_ROOT + File::SEPARATOR + ".."),'.abacus_db','abacus')%>
      timeout: 5000

    system:
      default:
        0:
          z,s
        1:
          t,d,th
        2:
          n
        3:
          m
        4:
          r
        5:
          l
        6:
          j,ch,sh,dge
        7:
          k
        8:
          f,ph,v
        9:
          p,b

Following the above instructions you can create your own config file and specify your own system. Multiple systems are supported, simply put the one below the other within config.yml. 

To enhance the existing imported dictionaries with the Hèrigone system you need to launch from commandline:
 
    abacus db:herigone:generate :default [you can change default with your system name]
    
Then you can perform some interesting queries as follow:
    
    >>  HerigoneNumber.find_by_number(357)
    => #<Abacus::HerigoneNumber id: 19081, system: "default", number: 357>
    >>  HerigoneNumber.find_by_number(357).article_keys
    => [#<Abacus::ArticleKey id: 20159, the_key: "hemlock", raw_text: "hemlock">, #<Abacus::ArticleKey id: 26062, the_key: "milk", raw_text: "milk">, #<Abacus::ArticleKey id: 26068, the_key: "milky", raw_text: "milky">]
    >>  HerigoneNumber.find_by_number(357).article_keys.map{|a| a.the_key}
    => ["hemlock", "milk", "milky"]
    
    
CONCLUSIONS
-----------

If you need more informations please have a look at the source code, or send me an email to sandro dot paganotti at gmail dot com.  