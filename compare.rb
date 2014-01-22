require 'open-uri'
require 'json'
require 'trollop'
require './hashdiff'

opts = Trollop::options do
	version "0.0.1 (c) by COSEA. Released under modified BSD. See LICENSE.txt for details."

	banner <<-EOS
	Simple JSON comparator that can read files or urls and compares them

	Usage:
	ruby compare.rb [options]
	where [options] are:
	EOS

	opt :original, "The URI to the original JSON, can be a file or an url", type: :string
	opt :check, "The URI to the JSON under test, can be a file or an url", type: :string
	opt 'auth-original', "The user:pass combination to use in http basic auth for the original", type: :string, default:'' 
	opt 'auth-check', "The user:pass combination to use in http basic auth for the json under test", type: :string, default:'' 
	opt 'ignore', "List of keys to ignore, comma separated. Keys specified here will always be skipped", type: :string, default:'' 
	opt 'ignore-array-ordering', "If true, will ignore the ordering of arrays", type: :boolean, default: false
end

Trollop::die :original, "must be given" unless opts[:original]
Trollop::die :check, "must be given" unless opts[:check]

# parse the data into hashes
original_data = JSON.parse open(opts[:original],http_basic_authentication: opts['auth-original'].split(':')).read
check_data = JSON.parse open(opts[:check],http_basic_authentication: opts['auth-check'].split(':')).read

options={}
options[:ignore_array_ordering] = opts['ignore-array-ordering']
options[:ignored_keys] = opts['ignore'].split(',')

exit 0 if HashDiff.same? original_data,check_data,options
exit 1
