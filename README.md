# FitnessWiki
As an aspiring iOS dev and Bodybuilding enthusiast,
FitnessWiki is a personal fitness app project tailored to help me grow myself in both my ios Development & bodybuilding journies.

## How to run FitnessWiki on your device
- Sign up for [Api Ninjas](https://api-ninjas.com/) to obtain an api-key
- Create a `config.xcconfig` file in the Resources folder
- Create a variable named `API_NINJA_KEY` in the config file, the value must be your api-key from api-ninjas. Ex: `API_NINJA_KEY = YOUR_KEY`
- Run the app... tadaaa

## Approach
- Programming paradigm: Protocol-Oriented Programming
- Design Pattern: MVVM
- Development Process: Test-driven development

## Current features
The app is still in the very early stages (initial commit on: 16.06.2022).  
Currently, the app can list exercises from the exercises-endpoint provided by [Api Ninjas](https://api-ninjas.com/).

![Simulator Screen Recording - iPhone 13 Pro Max - 2022-06-20 at 00 25 52](https://user-images.githubusercontent.com/36043429/174502589-00ad38c0-80f0-4a64-9d52-8f728da1ce58.gif)

## Planned Features
- Search for nutrition facts in food
- Motivational Tab (list motivation videos and Quotes)
- Workout logs

## Known "issue"
FitnessWiki stores the API_KEY on the client side using `.xcconfig` & `info.plist` which means if the app gets published with an api-key, the key can be easily confiscated.
Obfuscation is an option, but it's too complicated for little reward. [Source](https://stackoverflow.com/a/29760836). 

## Tasks-List
### Exercises Listing
- [x] Create exercises Model
- [x] Create a networking Manager
- [x] send requests to the api-ninja
- [x] list exercises
- [ ] handle error response
- [ ] create unit and ui tests
- [ ] search and filter through the list

### Nutrition facts
*TBD*

### Motivational Tab
*TBD*

### Workout logs
*TBD*
