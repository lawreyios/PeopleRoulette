# Advanced Unit Testing in Swift

## Introduction
Do you want to build a car (Testable Architecture) that can run fast (less compile time), save petrol(repeated codes) and can be easily learnt(readable) & driven(picked up) by any licensed driver? Then you have come to the right place, in this tutorial, I am going to take you on a journey to build your **Swift-brand** car, using model **Swift 4.2**. 

## Building a Testable Architecture
As we advance to another level of our developer's journey, we will come to a point where we want to write more testable & reusable codes. Codes that can be easily understood without writing comments, and can be easily picked up by another developer. 

It is merely impossible to introduce one size fits all archiecture. But here, I am going to introduce one way of developing your project, mainly for medium-to-large applications, that can get you started in achieving 80% of what I just mentioned. I do not guarantee that this is the best way of developing, but I can say that it helps us achieve what this tutorial is written for; which is to go deeper into writing testable codes.

## Frameworks
I am going to assume that you already have understanding of how to use Xcode, Cocoapods and developing code in Swift. I will introduce here all the frameworks that we will be using to learn and develop our app (I will state the version I use as they may not work as it is forever):

1. [Quick 1.3.2 & Nimble 7.3.1](https://github.com/Quick/Nimble) - The Swift (and Objective-C) testing framework.
2. [Swinject 2.5.0](https://github.com/Swinject/Swinject) - A lightweight dependency injection framework for Swift.
3. [ObjectMapper 3.3.0](https://github.com/tristanhimmelman/ObjectMapper) - A framework to easily map model objects from JSON.
4. [Alamofire 4.7.3](https://github.com/Alamofire/Alamofire) - A HTTP networking library written in Swift.
5. [AlamofireObjectMapper 5.1.0](https://github.com/tristanhimmelman/AlamofireObjectMapper) - Works together with ObjectMapper & Alamofire
6. [RealmSwift 3.11.0](https://realm.io/docs/swift/latest/) - Database built for Mobile.

You can grab a copy of the Podfile [here](https://github.com/lawreyios/PeopleRoulette/blob/master/Podfile) as well as the Podfile.lock [here](https://github.com/lawreyios/PeopleRoulette/blob/master/Podfile.lock) to ease your trouble.

## The Architecture
We have now come to the main ingredient of this tutorial, the body of the car, the engine, the wheels and the car seats which help build this archiecture.

1. **MVVM (Model View ViewModel) Design Pattern**: This will be the design pattern which we will be following, it is a trending iOS architecture that focuses on the separation of development of user interface from development of the business logic. The **ViewModel** acts like a glue to bind **Model** and **View**. The main component we will be performing our unit tests is the **ViewModel**.
2. **Protocol Oriented Programming**: Swift language is powered by protocols. They provide developers with the freedom of creating blueprints of classes, exposing only the right capabilities for other classes to use. The biggest plus point here is that capabilities make the codebase readable if they are properly defined.
3. **Dependency Injection (DI)**: [James Shore](https://www.jamesshore.com/Blog/Dependency-Injection-Demystified.html) says that *"Dependency injection means giving an object its instance variables. Really. That's it."*  **Dependency injection** is nothing more than injecting dependencies into an object instead of tasking the object with the responsibility of creating its dependencies. This gives us the flexibility of injecting objects to implement our test cases.

## Pre-requisite

Having understood all these frameworks and terminologies that we will be using to go through this tutorial, its time to get started! Clone or download this [Starter Project](https://github.com/lawreyios/PeopleRoulette/tree/starter) and we are ready to go! You will need:

1. [macOS 10.14](https://www.apple.com/sg/macos/mojave/) & above
2. [Xcode 10](https://developer.apple.com/xcode/) & above
3. [Cocoapods 1.5.3](https://cocoapods.org/) & above

Once you have gotten your starter project, run `pod install` to ensure all frameworks are properly installed.
> You may have noticed that there is a `testing_pods` in our PodFile, that is intentionally defined to ensure testing pods are only installed for our tests target.


## People Roulette
Today we will be building a very simple **People Roulette App** as we go through this tutorial. This app serves like a simple random generator to randomly select people. For example, everyone is tired and resting in the hotel, but you needed one guy to get some beer for a night party and no one wants to go, you could use this app to pick one unlucky guy. :P

### Project Skeleon
Open the project with Xcode and you should see a project structure as such:

1. **Model** -> User 
2. **Utilities**
	1. **DependencyAssembly.swift** (Dependency Injections)
	2. **Constants** (Constant values)
	3. **Handlers** (RealmDB & Roulette functions)
	4. **Network** (API/Network relation functions)
	5. **Services** (Helper Functions)
3. **Extensions** (Some extension of existing capabilities)
4. **Features** (Components of the App)
5. **Resources** (Storyboard, Assets, Info.plist)

This project structure helps us to find a specific file faster *(i.e. when working on Roulette feature, just go to features and jump in to the related files)*.

### Implement UsersHandler (Building the Rolulette)
First and foremost, we will need a list of users. Instead of hardcoding them, we are going to get it from an open public API from [here](https://jsonplaceholder.typicode.com/users).

> Let's think MVVM

The **View** will notify its **ViewModel** to pull data using **Handler**, after the **Handler** receives data, it will update the **Model** which eventually will be retrieved and updated back to **ViewModel**, which will end of a UI update back to **View**.

For simplicity, the **User** Model class has already been completed for you. Let's head over to **UsersHandler** class and start working from here. We have 2 protocols:

```
protocol UsersDownloading {
    func getUsers(completion: @escaping ([User]?, String?) -> Void)
}

protocol UsersRetrieving {
    func loadUsers() -> [User]?
}
```

1. `UsersDownloading` helps us to get users data from the server and save it into our **RealmDB**. 
2. `UsersRetrieving` helps us to get users data from the **RealmDB**.

We will complete `getUsers` function by implementing this:

```
    func getUsers(completion: @escaping ([User]?, String?) -> Void) {
        let request = APIRequest(url: URL.baseURL + EndPoint.users, method: .get)
        apiHandler.sendRequest(request) { success, data, errorMessage in
            guard success else {
                completion(nil, AlertMessage.requestFailure)
                return
            }
            
            guard let users = Mapper<User>().mapArray(JSONObject: data) else {
                completion(nil, AlertMessage.requestFailure)
                return
            }
            
            self.purgeUsers()
            self.saveUsers(users)
            
            completion(users, nil)
        }
    }
```
1. First we created an `APIRequest` struct, give it a `URL` and `method`.
2. Then we pass it to `apiHandler` which leverage on `Alamofire` to make the HTTP call.
3. Once it gets response, the `guard` statements will handle any error response and the `ObjectMapper` will map JSON response data to `User` Models.
4. We will then flush over any existing data in `RealmDB`.
5. Then save the latest data.
6. Since its an `@escaping` completion block function, we will need to pass it some completion values to exist the function.

Now lets complete the handler class by implementing the rest:

```
    private func purgeUsers() {
        realmPurger.deleteObjects(for: User.self, cascade: true)
    }
    
    private func saveUsers(_ users: [User]) {
        realmSaver.saveObjects(users)
    }
    
    func loadUsers() -> [User]? {
        return realmRetriever.getObjects(for: User.self) as? [User]
    }
```
1. `purgeUsers` uses `RealmDB`'s `deleteObjects` function to delete all users data.
2. `saveUsers` uses `RealmDB`'s `saveObjects` function to save all users data.
3. `loadUsers` uses `ReamDB`'s `getObjects` function to retreive all users data.

We will not talk more about RealmDB here, for more info you could read their docs [here](https://realm.io/docs/swift/latest/). 

### Unit Testing UsersHandler (Building the Rolulette)
Here, we are going to write on first test for making a network call to `Get Users`. Open up `UsersHandlerSpec.swift` and we are going to start writing our test implementation in `spec()`. For more info about using **Quick & Nimble** please go [here](https://github.com/Quick/Nimble). 

Since its network related, we would not want to test the real network call as sometimes server might fail, or network might be unstable, so we are going to leverage on the powerful method of [Mock](https://en.wikipedia.org/wiki/Mock_object). By **Mocking**, we can control cases such that the:

1. The network call always succeed/fail.
2. The network call always returns the correct/incorrect data.

This way, we can write test cases around what happened in each case.

So go ahead and add this bunch of test codes:

```
    override func spec() {
        
        // 1
        let usersHandler = UsersHandler()
        usersHandler.realmPurger = MockUsersPurger()
        usersHandler.realmSaver = MockUsersSaver()
        
        // 2
        describe("Given a users list url") {
            beforeEach {
                usersHandler.apiHandler = MockAPIHandler(success: true, data: MockUsersJSON.data, errorMessage: .empty)
            }
            
            context("and a network call is established") {
                it("should get users list") {
                    // 3
                    usersHandler.getUsers(completion: { users, errorMessage in
                        expect(users!.count).to(equal(1))
                        expect(users!.first!.name).to(equal("Leanne Graham"))
                        expect(errorMessage).to(equal(String.empty))
                    })
                }
            }
            
            context("and a network call fails") {
                beforeEach {
                    usersHandler.apiHandler = MockAPIHandler(success: false, data: nil, errorMessage: AlertMessage.requestFailure)
                }
                
                it("should not get users list") {
                    usersHandler.getUsers(completion: { users, errorMessage in
                        expect(users).to(beNil())
                        expect(errorMessage).to(equal("Request Failure"))
                    })
                }
            }
        }
    }
```
1. We first load in the appropriate mock classes from our `RealmHandler` but we are not testing anything related to DB. This is essential as our `getUsers` method users their functions and test will crash if no object is mapped to them.
2. We then write 2 suite of test cases (success & failure).
3. Here we call the same api function but we test against the function to ensure that it handles the response correctly.

Wow! thats a huge amount of effort put in just to create a method for a network call! Yes, it does, but hard work will pay off. With components more loosely coupled, you can better split up the workload, do pair programming and write more robust code.

So we are going to now move up one level, to use `UsersHandler` in our `PeopleRouletteViewModel`.

## Implement PeopleRouletteViewModel (Building the Roulette)
Remember that `ViewModel` retrieves data from `Model` and prepare them to be used in `View`. Go ahead and put in these codes:

```
class PeopleRouletteViewModel {
    
    var usersDownloader: UsersDownloading!
    var usersRetriever: UsersRetrieving!
    
    // 1
    private var users: [User] {
        return usersRetriever.loadUsers() ?? []
    }
    
    // 2
    var maxCount: Int { return users.count }
    var minCount: Int { return 1 }
    
    var pickerData: [Int] {
        var tempData = [Int]()
        for number in minCount...maxCount {
            tempData.append(number)
        }
        return tempData
    }
    
    // 3
    func getUsers(completion: @escaping (Bool, String) -> Void) {
        usersDownloader.getUsers { users, errorMessage in
            guard let users = users, !users.isEmpty else {
                completion(false, errorMessage)
                return
            }
            
            completion(true, .empty)
        }
    }
}
```
1. Using our `UsersRetriever` protocol, we `loadUsers` from our `RealmDB` after `getUsers` successfully retrieve users from the server.
2. Here we are using `maxCount` and `minCount` to determine the lower and upper bound of our `UIPicker`.
3. This function is similar to `UsersHandler`, except that we no longer pass users to `View`, we only inform the `View` if the call is successful.

## Unit Testing PeopleRouletteViewModel (Building the Roulette)
Open up `PeopleRouletteViewModelSpec.swift` and implement these codes:

```
class PeopleRouletteViewModelSpec: QuickSpec {
    override func spec() {
        let viewModel = PeopleRouletteViewModel()
        
        describe("Given a roulette") {
            // 1
            context("and downloading of users is successful") {
                beforeEach {
                    viewModel.usersDownloader = MockUsersDownloader(users: MockUsers.data, message: .empty)
                }
                
                it("should get the correct response") {
                    viewModel.getUsers(completion: { success, errorMessage in
                        expect(errorMessage).to(beNil())
                        expect(success).to(beTrue())
                    })
                }
            }
            
            // 2
            context("and downloading of users is unsuccessful") {
                beforeEach {
                    viewModel.usersDownloader = MockUsersDownloader(users: [], message: AlertMessage.requestFailure)
                }
                
                it("should get the correct response") {
                    viewModel.getUsers(completion: { success, errorMessage in
                        expect(errorMessage).to(equal(AlertMessage.requestFailure))
                        expect(success).to(beFalse())
                    })
                }
            }
            
            // 3
            context("and there are 3 available users") {
                beforeEach {
                    viewModel.usersRetriever = MockUsersRetriever()
                }
                
                it("should allow selection of minimum 1 person") {
                    expect(viewModel.minCount).to(equal(1))
                }
                
                it("should allow selection of maximum 3 people") {
                    expect(viewModel.maxCount).to(equal(3))
                }
                
                it("should populate picker data correctly") {
                    expect(viewModel.pickerData).to(equal([1, 2, 3]))
                }                
            }
        }
    }
}

// 4
class MockUsersDownloader: UsersDownloading {
    var users: [User]?
    var message: String
    
    init(users: [User]?, message: String) {
        self.users = users
        self.message = message
    }
    
    func getUsers(completion: @escaping ([User]?, String) -> Void) {
        completion(users, message)
    }
}

// 5
class MockUsersRetriever: UsersRetrieving {
    func loadUsers() -> [User]? {
        return MockUsers.data
    }
}
```
1. Here we are testing the scenario when `getUsers` succeeds.
2. Here we are testing the scenario when `getUsers` fails.
3. Here we are testing that the right data is prepared and accurate.
4. Again, we are leveraging on the power of Mocking to simulate data from `API Call`.
5. Again, we are leveraging on the power of Mocking to simulate data from `RealmDB`.

> Now run the test by using CMD+U or Product -> Test and you should see all your test cases passed!

## Implementing PeopleRouletteViewController (Building the Roulette)
Give yourself a big pat on your back! We are almost there, what we have just did is actually the most tedious part of the tutorial, I encourage you to repeat the previous steps by re-downloading the starter project and do it without looking at this tutorial. 

Now we are going to display the prepared data to users on the app. Add these missing codes which we just implemented in the `ViewModel` layer to use it now in the `View`:

```
    private func getUsers() {
        showLoadingSpinner()
        peopleRouletteViewModel.getUsers { [weak self] success, errorMessage in
            guard success else {
	            self?.hideLoadingSpinner()
                self?.showErrorAlert(with: errorMessage)
                return
            }
            
            self?.hideLoadingSpinner()
        }
    }
```
When the network is making the network call, show spinner until it responded.

```
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return peopleRouletteViewModel.maxCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(peopleRouletteViewModel.pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOfPeople = peopleRouletteViewModel.pickerData[row]
        quantityTextField.text = String(numberOfPeople)
    }    
```
Once the `ViewModel` has results, use it to determine the number of rows, which is equivalent to the number of people. Transform each `Int` value to `String` to display it in our picker view. Then set in to our textField once its selected.
> Now this power up our app to now be able to retrieve users list from server, and choose the number of people based on its data.

###Now run the app and .... OOPS! did the app just crashed?
Yes it did, that's because `peopleRouletteViewModel` is being forced unwrapped but it doesnt point to any object yet. Here is where we will introduce `Dependency Injection`. Instead of initialising `PeopleRouletteViewModel` here, which will then require us to initialise all the classes in it, we will use `Swinject` to help us inject all our dependencies.

Head over to `DependencyAssembly.swift` and update these: 

```
	defaultContainer.storyboardInitCompleted(PeopleRouletteViewController.self) 	{ resolver, controller in
		controller.peopleRouletteViewModel = resolver.resolve(PeopleRouletteViewModel.self)
	}
```			        

and head over to `registerViewModels` to update `PeopleRouletteViewModel` with

```
    defaultContainer.register(PeopleRouletteViewModel.self) { resolver in
        let viewModel = PeopleRouletteViewModel()
        viewModel.usersDownloader = resolver.resolve(UsersDownloading.self)
        viewModel.usersRetriever = resolver.resolve(UsersRetrieving.self)
        return viewModel
    }
```
Tadaa! We are now good to go. Just like a car needing a key to start the engine, all these dependencies help us to kick start the car. 
###Run the app now and you should see your app running and you can choose number of people!

##Implement RouletteHandler
I am going to go a little faster from here, as it will be the same ritual. 

1. Implement Handler (Capability)
2. Implement View Model (Prepare Data with Capability)
3. Implement View (Use Data)
4. Implement Unit Tests

Open up `RouletteHandler.swift` and implement the following:

```
// 1
protocol PeopleRouletting {
    func getRouletteResults(for numberOfPeople: Int) -> [User]
}

class RouletteHandler: PeopleRouletting {
    
    var usersRetriever: UsersRetrieving!
    
    // 2
    func getRouletteResults(for numberOfPeople: Int) -> [User] {
        guard let users = usersRetriever.loadUsers() else {
            return []
        }
        
        return users.sample(UInt(numberOfPeople))
    }    
}
```

1. The capability of this class is to apply **Roulette** based on the users list and number of people selected.
2. The logic here is to leverage on [Darwin](https://www.ralfebert.de/ios-examples/swift/array-random-sample//) to generate unique random users.

That's all, you are ready to use your roulette! But before we jump right in, let's unit test this handler so as to "lock down" its logic.

##Unit Testing RouletteHandler
Head over to `RouletteHandlerSpec.swift` and implement these:

```
class RouletteHandlerSpec: QuickSpec {
    override func spec() {
        let handler = RouletteHandler()
        handler.usersRetriever = MockUsersRetriever()
        
        describe("Given a roulette") {
            var randomUsers = [User]()
            
            // 1
            context("when getting a random user") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 1)
                }
                
                it("should return one user") {
                    expect(randomUsers.count).to(equal(1))
                }
            }
            
            // 2
            context("when getting more than 1 random user") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 2)
                }
                
                it("should return 2 users") {
                    expect(randomUsers.count).to(equal(2))
                }
            }
            
            // 3
            context("when getting all users") {
                beforeEach {
                    randomUsers = handler.getRouletteResults(for: 3)
                }
                
                it("should all 3 unique users") {
                    let firstUserExist = !randomUsers.filter({ $0.name == "User 1" }).isEmpty
                    let secondUserExist = !randomUsers.filter({ $0.name == "User 2" }).isEmpty
                    let thirdUserExist = !randomUsers.filter({ $0.name == "User 3" }).isEmpty
                    expect(firstUserExist).to(beTrue())
                    expect(secondUserExist).to(beTrue())
                    expect(thirdUserExist).to(beTrue())
                }
            }
        }
    }
}
```
1. We need to test that our handler supports generating one random user.
2. We need to test that it also support more than 1 user.
3. We need to test that all values are unique by testing against getting all users.



    
