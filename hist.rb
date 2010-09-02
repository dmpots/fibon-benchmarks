#!/usr/bin/env ruby
puts `git log --date=short --format=format:"%ad %s" | grep Added.\*benchmark`
