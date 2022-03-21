# WeatherApp

## What i used for this?
- XCTests
- SwiftLint for code standard
- SwiftFormat to format the code
- Kingfisher for image loading
- SnapKit for view coding
- Network requests using Alamofire
- MVVM based application architecture
- Cocoapods

## How to Run
- The project was develped using Xcode 13.1 and Swift 5.5.
- The dependency manager used was Cocoapods.
- You may need the Ruby installed in your computer in order to run cocoapods.
[Here is](https://gorails.com/setup/osx/11-big-sur#ruby) some reference to install it on the MacOS.
- After download the project and install ruby execute the commands below.

```
$ bundle install

$ pod install
```

## Notes
- DarkMode is disable to simplify the implementation for now.
- Did right any unit tests until right now because of time constraint.
- I prefer using third party libraries in order to keep the things simpler and reliabe. These libraries are broadly used by the community.
In the real world project, I also prefer to rely on these libraries until I have to do something with too much customization.
- The architecture is based on MVVM which uses Delegate pattern in order to sync view and data.
I choose this architecture mainly because the simplicity which will also let the things prepared for unit/integration tests.
- There is a lot of dependency injection pattern through all the code, favoring tests.
