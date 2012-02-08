# Simplecov-cli - quick test-coverage checks of any repo

This is a quick ruby script to pull the repository of ruby code, run its tests and display the code coverage of its test suite.

## Current Example

1. Clone this repo so you have the code on your local system
2. Find the URL of a project whose code coverage you would like to check
3. Start the script by calling ````./simplecov-bash.rb "url"````

## Future Enhancements

* I am curious to try to write this all in bash
* Add functionality to test rails apps
  * add options to .simplecov file
* Find a way to run all tests if a project has multiple tools (i.e. RSpec and Cucumber)
* Find a way to clean up after running the script
  * Might be interesting to keep a folder of html results for all the different projects with a unique ID so that you could check over time and see changes in coverage
