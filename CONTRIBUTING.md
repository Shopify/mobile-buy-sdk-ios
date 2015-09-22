# How to contribute

## Things we will merge

* Bugfixes
* Performance improvements
* Features which are likely to be useful to the majority of users

## Things we won't merge

* Code which adds no significant value to the SDK
* Code which comes without tests
* Code which breaks existing tests

## Workflow

* Fork the repo and branch off of `develop`
* Create a new branch in your fork
* If it makes sense, add tests for your code 
  * New keys should be added to `test_shop_data.json`, but don't check in their values
* Make sure all tests pass
* Create a pull request
