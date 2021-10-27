I encourage you to read this reamd me file, please.
*(As asked, inside the main path, there is a recording of the app.)*
# 1- POC App:  
I chose a Movies API, and I am pulling the top rated movies from there.
That list of movies is the one presented in this test.

Requirements:  
1. Create a view to make the Login, without API call.  
********** *DONE* ********* a.  Validate the email and password  
********** *DONE* ********* b.  The next time the application is opened, if I have  already logged in, it should  
send me directly to home  

2.  Bottom navigation tab bar:  
********** *DONE* *********  a.  With two pages, one implemented and one dummy  
********** *DONE* *********  b.  Home page: implement the Home list page with:  
********** *DONE* *********         i.  Scrollable list content.  
********** *DONE* ********* ii.  Show the first 20 elements from API and request next  elements via  
pagination  
********** *DONE* ********* iii.  Favorite button on each item, that is persisted between  app launches.  

3.  ********** *DONE* ********* Detail page: user should be able to navigate to the  detail page when the user touches  
on each item in the home page list. This page should  open in a new page.  


Nice to have for this POC app:  
1.  ********** *DONE* ********* Have a good architecture for the application.  
2. ********** *DONE* *********  Implementing a typeahead input for search in the home  page.  
a. ********** *DONE* *********  Filtering elements  
3.  ********** *DONE* ********* Instead of a dummy tab implementing the favorite list.  
4.  Animation transaction between home and detail page.

# General Comments
This app has clear abstraction of tasks and responsibilities for each file and has decoupled UI with business logic. That way it is testable, scalable and well structured.
It also has a layer that separates (decouples) the View from the API and Models Layers.

# Files Structure in XCode

```
+-- TechTest
|   +-- Networking
|   |  +-- MovieAPI
|   |  |  +-- MovieAPI.swift
|   |  |  +-- MovieAPIItemServiceAdapter,swift
|   |  +-- Networking.swift
|   |  +-- ItemServiceProtocol.swift
|   +-- Utils
|   |  +-- UIViewController+Extension.swift
|   |  +-- ActivityIndicator.swift
|   |  +-- PersistanceDataHandler.swift
|   +-- Resources
|   |  +-- Assets.xcassets
|   +-- Models
|   |  +-- User.swift
|   |  +-- Movie.swift
|   +-- Views
|   |  +-- CustomCells
|   |  |  +-- CustomTableCell.swift
|   |  +-- Login
|   |  |  +-- LoginViewController.swift
|   |  |  +-- LoginViewController.xib
|   |  +-- TabBarViewController.swift
|   |  +-- ItemsTableViewController.swift
|   |  +-- ItemDetailViewController.swift
|   |  +-- ItemDetailViewController.xib
|   +-- ViewModels
|   |  +-- LoginViewModel.swift
|   |  +-- ItemViewModel.swift
|   |  +-- ItemsViewModel.swift
+-- AppDelegate.swift
+-- SceneDelegate.swift
+-- LaunchScreen.storyboard
+-- Info.plist

## Approach
I tried to do this as clean as possible under the time limitation I had. The intention is to create a testable, scalable and maintainable code
This was done using the MVVM pattern.
The View controller that lists items was done very generic and following SOLID principles and it only deals with UI related things. Its view model gives him all things needed to work as expected.

## Functions

 - App asks for email and password if not saved before
 - A list of top rated movies are pulled from api.themoviedb.org. Once the bottom of the table is reached it pulls 20 more and so on.
 - Top Movies and favorite movies list are functional and each one has a tab where they are presented. Both tables have search functionality.
 - Each cell has a start (filled or not) showing if a movie is favorited or not. Touching the star, the status is toggled.
 - There is an activity indicator implemented for background tasks like pulling data from the API
 - Favorite movies and user info are persisted between app launches

## Disclaimer - Possible improvements

 - To get a testable, scalable and maintainable code, it is needed more at the beginning of the development process than creating and ugly code that does not allow to maintain, test and scale, so the intention was to add some unit test but I did not have time, so I preferred to focus on Test's specs and bonus points.
 - **Potential improvements:**
	 -  Get not a dummy login but an actual login page that does not allow to do anything after successfully logged in and that is presented logically better.
	 - Strings could be grouped in a common file and add a better architecture for them in order to easily add localization if needed.
	 - Persist login information and favorited movies with a better approximation. Right now it uses User Defaults, and it is error prone. With more time it could be done using tools like realm/firebase or even core data.
	 - The cells from Favorites list does not have action when selected, this is a known issue not fixed because of a lack of time (Sorry).
	 - Similar to previous bullet, when a cell is filtered, it does not allow to toggle favorited status.

