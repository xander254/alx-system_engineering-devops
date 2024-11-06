#!/usr/bin/env ruby
puts ARGV[0].scan(/\d/).join[0, 10] if ARGV[0]
