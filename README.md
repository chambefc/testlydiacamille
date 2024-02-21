## Getting Started

This project was built without any dependency, just open the Test Lydia.xcodeproj and build the app.
You will have to set your own Development Team and Bundle Identifier

### Prerequisites

* iOS 17+

## ✅ Features

Mandatory:
- [x] Fetching remote users
- [x] Data persistency (caching) with picture persistency
- [x] Automatic paging
- [x] Refresh of the user list

Bonus:
- [x] Localization
- [x] Dark / Light Mode (You can go from one to another pressing Cmd + Shift + A)
- [x] Real time Network monitoring
- [x] Display of a Map in the User Details
- [x] Theming (All UI related values are stored in the Theme file)
- [x] Unit Tests

## 🔝 Suggested improvements

#### In app features

- [ ] Full screen picture on tap
- [ ] Search feature
- [ ] Filter feature
- [ ] Favourite Users feature with local storage
- [ ] Theming injection

#### QOL

- [ ] Add Coordinator management for greater scalability
- [ ] CD with Fastlane lane
- [ ] CI configuration with Travis CI

### Code implementation

I used MVVM as design pattern for this test in conjunction with Combine for the binding of the View and the ViewModel.
I also used a Repository pattern for handling the call building and handling.
Dependency injection has also been used everywhere possible to allow for greater testability.
The persistency is achieved using Apple's new framework SwiftData.
The asynchronous calls are made using async/await instead of "traditional" callbacks which allows for better control of workflow as well as better readability and general code cleanliness.

### What I could improve

- [ ] The NetworkClient could greatly benefit of a retry feature. This is not something I usually do but I focused on getting the whole project functional, with a good user experience.
- [ ] The error handling is also subpar and could be greatly improved. I also consider that the user should not be exposed to "debug errors" such as invalid responses or decoding errors. The app should have dedicated Error texts or better get localized error messages from the API.
- [ ] The NotificationBanner could benefit from a sliding effect, which I didn't have the time to do.
- [ ] Test coverage.
- [ ] UI Tests
- [ ] Dependency injection using property wrappers instead of swapping singletons for testing or passing references everywhere.
- [ ] Implement a hero transition on tap on a picture to display it full screen, like in the Apple App Store.

## 👨🏻‍💻 Author

* [**Camille Chambefort**](https://github.com/chambefc/)
