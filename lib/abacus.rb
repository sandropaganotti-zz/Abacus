require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'active_record'
require 'fileutils'
require 'yaml'
require 'erb'

module Abacus
  LIB_ROOT = File.dirname(__FILE__)
end

require File.join(File.dirname(__FILE__),'abacus','main')

