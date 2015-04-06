UTFOR is a generic test automation framework for acceptance testing and Behaviour Driven Development for Ruby (BDD).
The scope of creating such a framework was - add simple, flexible and universal tool to quickly run the smoke/sanity checks based on any given Web App tree of links

Universal Test Framework for Ruby was created using Ruby language as core data driven engine and the following support libraries: 

• Watir-Webdriver (For interaction with web apps).

• Rspec and Cucumber (For test definition and reports transparency using business level Domain-specific language (DSL)).

• Rake (Running tests in batch; parallel runs; categorizing tasks). 



Its testing capabilities can be extended by test libraries implemented either with Ruby and Rspec, and users can create new higher-level keywords from existing ones using the same syntax that is used for creating test cases. 
Few of the features include:


• Supports cross browser (IE, Firefox, Chrome, Opera).


• Supports running tests in parallel (using rake runner).


• Contains custom logger with filters and pass/fail results, using Rspec logger in HTML format 


• Includes additional logger with timestamps and screens for each test step.


• Continuous Integration with Jenkins. 
