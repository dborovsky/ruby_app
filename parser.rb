require 'pry'
require_relative 'log_parser'

LogParser.new(ARGV[0]).call
