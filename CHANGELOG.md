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
