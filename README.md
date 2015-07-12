# mydrive-currency-converter
A currency converter for mydrive

This is my solution to the following problem:

https://github.com/mydrive/code-tests/blob/master/iOS-currency-exchange-rates/test.md

## Development process:

The first thing I did was think about it;

There is no need for a complex, or even aesthetically pleasing, interface, as the requirements do not list it.
Maybe the UI should be pleasant and easy to use in any case, because I stil have to sell this solution to the client.

The main problem here is that we are required to provide conversions between all currencies but we're not given conversion rates between all currencies.

I'm assuming that the term 'all currencies' is referring to all currencies listed in the JSON file given, otherwise we would have to cheat by obtaining the rates from a third party and ignoring the JSON file.

I could still do this; in a real life situation this would be a viable option.

I have noticed that all the currencies do have a conversion rate to or from us dollars, so I could use this as a base rate and set up a dictionary containing conversion rates to us dollars for all currencies

I'm thinking that there might be a better way, but trying to think of a better way is taking time, so I may have to abandon it and use the method I have now.

I have created the git repo and filled it with an empty project, so now I'm going to have a little think about a better process.

I could calculate a rate table between all currencies from the rates I have, but this would take up a lot more storage and cost initial processing time that will either delay the users ability to start entering numbers or may not be complete by the time the user requests a conversion.

The next stage of development was to create a class to handle the data and set up a data source for the view.

I chose to create the data handler as a singleton so that the download and calculations would only take place once and the data would be available and only take up as much memory as it needed to.

## unit tests
I don't know how to do unit tests, so I skipped this part

## Evaluation
- The UI coud do with a lot of improvement
- Whilst working on this I realised that there being a relationship to USD for every other currency, which there currently is - a better way would be to construct a matrix of conversion rates (dictionary of dictionaries), but this would mean the conversion rates would be calculated before the user chooses the currencies.
- There is no validation of data entered into the from field, other than setting the keypad numerical, i.e. it would be perfectly possible to enter more than one point.
- Something needs to be done in the event that the first execution takes place offline, then no file is available.

## time taken
Approximately six hours

## bonuses
I believe I have covered all of the bonuses:
- The development process is documented in this readme
- I created seperate branches for development and my own work in progress, which was merged with the development branch by pull request. The development branch was merged with master when the team lead (me) decided it was stable enough for release.
- A file is saved to store offline data, which is used when offline.

## additional questions
- I don't keep up with the latest ios development practices as I am still learning ios development.
- I don't trust third party libraries as they have no support structure and the licencing could cause issues.
- The only tools I use are xcode and sourcetree and I could easily live without sourcetree.
