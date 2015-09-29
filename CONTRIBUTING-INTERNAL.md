# Internal Contribution to Mobile Buy SDK

## Workflow

* clone the private repo and branch off of `develop`
* If it makes sense, add tests for your code 
  * New keys should be added to `test_shop_data.json`, but don't check in their values
* Make sure all tests pass
* Create a pull request back into `develop`

## Deployment to public repo

* add a remote to you private repo pointing to the public repo
	`git remote add public git@github.com:Shopify/mobile-buy-sdk-ios-private.git`
* [Use rebase to squash your commits](http://gitready.com/advanced/2009/02/10/squashing-commits-with-rebase.html) before pushing to the public repo so features are delivered in a single commit


## Releases

* tag the commit with the release version number
* create a `Release` on github, pointing to the tag
* run the `Universal Framework` scheme using the `Release` configuration, and zip the contents of `Mobile Buy SDK Sample Apps` folder when complete
* upload the zip file buy-sdk-ios-x.y.z.zip and attach it as a binary to the `Release`
