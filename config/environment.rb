require 'bundler/setup'
Bundler.require

Dotenv.load

Dir["/lib/*.rb"].each {|file| require file }
