# Shopify's Mobile Buy SDK tvOS Sample App

### Motivation
The tvOS sample app is intended to show users how to integrate Shopify's Mobile Buy SDK into their tvOS applications.

The tvOS sample app demonstrates how to perform several tasks:
- Fetching shops
- Fetch collections
- Fetch products within specific collections
- Fetching and displaying product images
- Using the currency formatter specified by the shop
- Creating nested collection views to function as shelves for products 
- Using the Focus Engine to focus on products
- Creating a `UIPageViewController` to display product images 

### Getting Started 
Add your shop domain, API key and App ID to `AppDelegate.swift`

```swift
let shopDomain: String = "<shop_domain>"
let apiKey:     String = "<api_key>"
let appID:      String = "<app_id>" 
```


### Classes
#### View Controllers

###### `ViewController.swift`
* Initializes the `CollectionsViewModel`
* Controls the Focus Engine and decides which items can be focused
* Handles the selection of a product - initializes `PageViewController` and presents the view controller if the product has images, else shows an alert

###### `PageViewController.swift`
* Initializes `ProductImageViewController` for each product image and caches it for later use
* Conforms to `UIPageViewControllerDataSource` and implements methods to configure the view controller
* Has several helper methods that help with initializing the finding the index of a specific  `ProductImageViewController`

###### `ProductImageViewController.swift`
* Simply contains an `AsyncImageView` that is used to display the product image given a `BUYImageLink`


### Data Provider

###### `DataProvider.swift`
* Handles all network requests within the app - fetching shop, collections and products
* Has a local cache for everything it fetches


#### View Models

###### `BaseViewModel.swift`
* Manages an `Operation` and makes sure that if it's receiving another `Operation` to cancel the previous one

###### `CollectionsViewModel.swift`
* Subclasses `BaseViewModel`
* Interacts with `DataProvider` to download collections and store them in its local cache
* Dequeues `CollectionViewContainerCell`, initializes `ProductViewModel` and configures the cell with the view model and the collection title

###### `ProductsViewModel.swift`
* Subclasses `BaseViewModel`
* Interacts with `DataProvider` to download products of its collection
* Dequques `ProductCollectionViewCell`, initializes `ProductItem` and configures the cell with the `ProductItem`, price and title


### Other

###### `AsyncImageView.h`
* Subclasses `UIImageView` and loads images asynchronously from a URL or `BUYImageLink`

###### `ProductItem.swift`
* Used to abstract model objects from views and view controllers
* Currently only contains product images but more product metadata can be added

###### `ImageItem.swift`
* Used to abstract model objects from views and view controllers
* Currently only contains a single image object buy more metadata can be added depending on use case 

All commits associated to this PR have been approved in the following PRs:
- PR #411 
- PR #420 
- PR #421 
- PR #425 
- PR #427 
- PR #430 
- PR #432 
- PR #433 
- PR #435 
- PR #445 
- PR #446 
- PR #449 
