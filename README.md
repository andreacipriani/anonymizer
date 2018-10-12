# Anonymizer

A simple Ruby tool to replace all references to specific words from all files in a folder, including folder names.
Do you want to remove your name/surname from a project?
- Open `anonymizer.rb` and set the values of `your_name` and `your_surname`. They will be replaced with the content of `anonymouse_name` and `anonymouse_surname` variables
The script won't maintain the case for the replaced words.

# test the script

- Run `ruby anonymizer.rb` with the default configuration
- Run `diff -ENwbur tests/anonymized-folder/ tests/expected` and there should be no differences. This means the generated folder matches the expected one
