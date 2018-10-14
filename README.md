# Anonymizer

A simple Ruby tool to replace all references to specific words from all files in a folder.
🕵️‍ Do you want to remove your name/surname from a project? 

### How to use it
- Open `anonymizer.rb` and set the values of `your_name` and `your_surname`. 
- Choose the `target_folder_path` of the parent folder that you want to anonymize and the `destination_folder_path`, where you will find your anonymous folder.
- Run `bundle install`
- Run `ruby anonymizer.rb`. 
- Your name/surname will be replaced with the content of `anonymouse_name` and `anonymouse_surname`
- The script doesn't maintain the case for the replaced words.

### Run the tests

- Run `ruby anonymizer.rb` with the default configuration
- Run `diff -ENwbur tests/anonymized-folder/ tests/expected` and there should be no differences. This means the generated folder matches the expected one
