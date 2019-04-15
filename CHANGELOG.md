## [1.1.1 - Swift 5.0](https://github.com/micheltlutz/MLTontiatorView/releases/tag/v1.1.1) (2019-04-14)

#### Add

* Support to Swift 5

-----

## [1.1.0 - Swift 4.2](https://github.com/micheltlutz/MLTontiatorView/releases/tag/v1.1.0) (2018-12-06)

#### Add
* Now Support image for spinner

## Usage
Example: ViewController > viewDidLoad

```swift
let viewActivitySmall = MLTontiatorView()
viewActivitySmall.spinnerSize = .MLSpinnerSizeSmall
viewActivitySmall.spinnerImage = UIImage(named: "mySpinnerImage")
self.view.addSubview(viewActivitySmall)
viewActivitySmall.startAnimating()
```

## [1.0.0 - Swift 4.2](https://github.com/micheltlutz/MLTontiatorView/releases/tag/v1.0.0) (2018-12-04)

#### Add
* initial project.

## Usage
Example: ViewController > viewDidLoad

```swift
let viewActivitySmall = MLTontiatorView()
viewActivitySmall.spinnerSize = .MLSpinnerSizeSmall
viewActivitySmall.spinnerColor = UIColor.purple
self.view.addSubview(viewActivitySmall)
viewActivitySmall.startAnimating()
```