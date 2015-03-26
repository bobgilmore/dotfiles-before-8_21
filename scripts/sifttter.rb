#!/usr/bin/ruby
# SIFTTTER 1.5: An IFTTT-to-Day One Logger by Craig Eley 2014 <http://craigeley.com>
# Based on tp-dailylog.rb by Brett Terpstra 2012 <http://brettterpstra.com>
# Multiple Date Function by Paul Hayes 2014 <http://paulrhayes.com>
#
# Notes:
# * Uses `mdfind` to locate a specific folder of IFTTT-generated text files changed in the last day
# * The location of your folder should be hardcoded in line 67, and the location of your Day One in line 66
# * Scans leading timestamps in each line matching the selected dates
# * Does not alter text files in any way
# * Changes ampersand ('&') to 'and' so the script keeps running
# * Does not require the Day One CLI tool
# * Only generates report if there are completed tasks found
# * Compiles each day into a single Day One entry
# * It's configured to locate a Dropbox-synced journal, so
# * If you use iCloud you'll can just uncomment lines 64 and 65, and comment line 66
# * To set the Day One entries to starred, just change false to true on line 24

require 'time'
require 'erb'
require 'date'
require 'optparse'

starred = false

template = ERB.new <<-XMLTEMPLATE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Creation Date</key>
	<date><%= filename %>T04:58:00Z</date>
	<key>Entry Text</key>
	<string><%= entrytext %></string>
	<key>Starred</key>
	<<%= starred %>/>
	<key>Tags</key>
	<array>
		<string>daily logs</string>
	</array>
	<key>UUID</key>
	<string><%= uuid %></string>
</dict>
</plist>
XMLTEMPLATE

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: sifttter.rb [options]"
  opts.on('-d', '--date DATE',   'Date to generate - Any parseable date string')           { |v| options[:date] = v }
  opts.on('-s', '--start START', 'Start date - Use with end to generate a range of dates') { |v| options[:start_date] = v }
  opts.on('-e', '--end END',     'End date - Use with start to generate a range of dates') { |v| options[:end_date] = v }
end.parse!

if options[:start_date] && options[:end_date]
  start_date = Date.parse(options[:start_date])
  end_date   = Date.parse(options[:end_date])
  date_range = (start_date..end_date).map { |date| date }
else
  date = options[:date] ? Date.parse(options[:date]) : Time.now()
  date_range = [date]
end

# dayonedir = %x{ls ~/Library/Mobile\\ Documents/|grep dayoneapp}.strip
# dayonepath = "~/Library/Mobile\ Documents/#{dayonedir}/Documents/Journal_dayone/entries/"
dayonepath = "/Users/#{ENV['USER']}/Dropbox/Apps/Day One/Journal.dayone/entries/"
files = %x{mdfind -onlyin /Users/#{ENV['USER']}/Dropbox/IFTTT -name '.txt' | grep -v -i daily | sort}

date_range.each do |date|
  formatted_date = date.strftime('%B %d, %Y')
  filename = (date + 1).strftime('%Y-%m-%d')

  projects = []
  files.split("\n").each do |file|
    if File.exists?(file.strip)
      f = File.open(file.strip, encoding: 'UTF-8')
      lines = f.read
      f.close

      # Uses filename as header for section, strips out filetype
      project = "### " + File.basename(file).gsub(/^.*?\/([^\/]+)$/,"\\1").capitalize + "\n"
      found_completed = false
      lines.each_line do |line|
        if line =~ /&/
          line.gsub!(/[&]/, 'and')
        end
        if line =~ /#{formatted_date}/
          found_completed = true

          # Removes formatted date and @done pattern from entry
          project += line.gsub(/@done/,'').gsub(/#{formatted_date}.../,'').strip + "\n"
        end
      end
    end
    if found_completed
      projects.push(project)
    end
  end

  if projects.length > 0
    entrytext = "# Things done on #{formatted_date}\n\n"
    uuid = %x{uuidgen}.gsub(/-/,'').strip
    projects.each do |project|
      entrytext += project.gsub(/.txt/, ' ') + "\n"
    end
    file = "#{dayonepath}#{uuid}.doentry"
    fh = File.new(File.expand_path(file),'w+')
    fh.puts template.result(binding)
    fh.close
    puts "Entry Generated for #{formatted_date}"
  end
end
