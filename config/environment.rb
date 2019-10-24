require 'bundler'
Bundler.require
# require_relative './app'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3')
require_all 'app'

ActiveRecord::Base.logger = nil