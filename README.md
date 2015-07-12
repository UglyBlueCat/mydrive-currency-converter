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
