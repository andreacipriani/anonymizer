#!/usr/bin/ruby
require "fileutils"
require "shellwords"

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

def renameDirectoryIfMatching(folder_to_be_renamed, file, replacements)
	renamed_file = replaceIfMatching(file, replacements)
	if renamed_file != file
		folder_to_be_renamed[file] = renamed_file
	end
	return folder_to_be_renamed
end

def replaceContentOfFileIfMatching(file, replacements)
	content = File.read(file)
	new_content = replaceIfMatching(content, replacements)
	if new_content != content
		puts "replacing occurences in file #{file}"
		File.open(file, "w") { |file| file.puts new_content }
	end
end

def isText(filename)
	escaped_filename = filename.shellescape
	output = `file -b --mime-type #{escaped_filename} | sed 's|/.*||'`
  	return output =~ /text/i
end

# Script

replacements = { your_name => anonymouse_name, your_surname => anonymouse_surname } 
FileUtils.copy_entry target_folder_path, destination_folder_path
folder_to_be_renamed = { } 

Dir.glob(destination_folder_path + "/**/*") do |file|
	is_directory = File.directory?(file)
	if is_directory
		folder_to_be_renamed = renameDirectoryIfMatching(folder_to_be_renamed, file, replacements)
	else
		if isText(file)
			replaceContentOfFileIfMatching(file, replacements)
		end
	end
end

folder_to_be_renamed.map { |file, renamed_file|
	file_exist = File.exist?(file)
	if file_exist
		puts "renaming file from #{file} to #{renamed_file}"
		FileUtils.mv file, renamed_file
	end
}

