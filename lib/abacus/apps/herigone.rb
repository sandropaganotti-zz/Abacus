module Abacus

  class Herigone
    
    attr_reader :name
    
    def initialize(name = 'default')
      @name, @system  = name, Hash[*(CONFIG_FILE['system'][name].to_a.flatten.map{|v| "#{v}"=~/,/ ? v.split(',') : v })]
      @rev_system = Hash[*(@system.to_a.map{|t| [*t[1]].map{|m|[m,t[0]]}}.flatten)]
    end
    
    def generate_on_db(*args)
      dictionaries = args.first.is_a?(Hash) ? Dictionary.all : args.shift
      options      = args.shift  
       
      Abacus.transaction do  
        dictionaries.each do |dict| 
          dict.articles.each do |art|
            art.article_keys.each do |ak|
              if (en = HerigoneNumber.first(:conditions=>{:number=>(n=to_number(ak.the_key)),:system=>@name})).nil?
                ak.herigone_numbers.create(:number=>n,:system=>@name)
              else
                ak.herigone_numbers << en
              end  
              puts "<< #{ak.the_key} to #{n}" if options[:verbose]
            end
          end
        end
      end
    end

    def to_word(string)
      raise TypeError.new("Fatal: #{string} is not a number") if (Float(string) rescue false)
      
    end
    
    def to_number(string)
      string.downcase.scan(Regexp.compile(@system.values.join('|'))).inject('') do |memo,nr_match|
         "#{memo}#{@rev_system[nr_match]}"
      end
    end
    
  end
  
end