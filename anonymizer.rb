#!/usr/bin/ruby
require 'fileutils'

# Configuration

your_name="andrea"
your_surname="cipriani"
anonymouse_name="jane"
anonymouse_surname="doe"

target_folder_path="tests/target-folder/"
destination_folder_path="tests/anonymized-folder/"

# Functions

def replace(string, substring, replacement)
	replaced = string.gsub(/#{substring}/i, replacement)
  	return replaced
end

def replaceIfMatching(string, replacements)
	replacements.map { |substring, replacement|
  		string_contains_substring = string =~ /#{substring}/i
  		if string_contains_substring
  			string = replace(string, substring, replacement)
  		end
	}
	return string
end

def replaceContentOfFileIfMatching(file, replacements)
	content = File.read(file)
	return replaceIfMatching(content, replacements)
end

# Script

replacements = { your_name => anonymouse_name, your_surname => anonymouse_surname } 
FileUtils.copy_entry target_folder_path, destination_folder_path
folder_to_be_renamed = { } 

Dir.glob(destination_folder_path + "**/*") do |file|
	is_directory = File.directory?(file)
	if is_directory
		renamed_file = replaceIfMatching(file, replacements)
		folder_to_be_renamed[file] = renamed_file
	else
		new_content = replaceContentOfFileIfMatching(file, replacements)
		puts "replacing occurences in file #{file}"
		File.open(file, "w") { |file| file.puts new_content }
	end
end

folder_to_be_renamed.map { |file, renamed_file|
	file_exist = File.exist?(file)
	if file_exist
		puts "renaming file from #{file} to #{renamed_file}"
		FileUtils.mv file, renamed_file
	end
}

