////MIT License
////
////Copyright (c) 2018 Michel Anderson Lüz Teixeira
////
////Permission is hereby granted, free of charge, to any person obtaining a copy
////of this software and associated documentation files (the "Software"), to deal
////in the Software without restriction, including without limitation the rights
////to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
////copies of the Software, and to permit persons to whom the Software is
////furnished to do so, subject to the following conditions:
////
////The above copyright notice and this permission notice shall be included in all
////copies or substantial portions of the Software.
////
////THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
////IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
////FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
////AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
////LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
////OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
////SOFTWARE.

import UIKit

/**
 class MLTontiatorView extends UIView

 ### Usage Example: ###
 ````
 let viewActivitySmall = MLTontiatorView()
 viewActivitySmall.spinnerSize = .MLSpinnerSizeSmall
 viewActivitySmall.spinnerColor = UIColor.purple
 self.view.addSubview(viewActivitySmall)
 viewActivitySmall.startAnimating()

 //or With image

 let viewActivitySmall = MLTontiatorView()
 viewActivitySmall.spinnerSize = .MLSpinnerSizeSmall
 viewActivitySmall.spinnerImage = UIImage(named: "mySpinnerImage")
 self.view.addSubview(viewActivitySmall)
 viewActivitySmall.startAnimating()
 ````
 */
open class MLTontiatorView: UIView {
    /**
     Lib name
     */
    public static let name = "MLTontiatorView"
    /**
     PI contant
     */
    private let pi = 3.14159265359
    /**
     Enum with Spinners Size declarations
     */
    public enum SpinnerSize: Int {
        case MLSpinnerSizeMini // suitable for frmae size (30, 30)
        case MLSpinnerSizeSmall // suitable for frame size (50, 50)
        case MLSpinnerSizeMedium // suitable for frame size (150, 150)
        case MLSpinnerSizeLarge // suitable for frame size (185, 185)
        case MLSpinnerSizeVeryLarge // suitable for frame size (220,220)
    }
    /**
     radius of the spinner/rotator will be different in each Spinner Size
     default = kAVSpinnerSizeTiny
     if its MLSpinnerSizeVeryLarge or MLSpinnerSizeLarge, MLSpinnerSizeMedium, can able to set two title, one title in.center of spinner and another in below the spinner
     */
    open var spinnerSize: SpinnerSize?
    /**
     spinner color
     default = UIColor.white()
     */
    open var spinnerColor: UIColor? = .gray
    /**
     Define an image for Tontiator and ignore color
     */
    open var spinnerImage: UIImage?
    /**
     spinner color
     default = UIColor.white()
     */
    open var spinnerGradientColors: [CGColor]?
    /**
     spinner angle indicates if spinner is open or not
     default = 360
     */
    open var angleSpinner: Double = 360
    /**
     Stop animation when showing and dismissing the spinner
     */
    private var stopShowingAndDismissingAnimation: Bool?
    /**
     disable the user interaction of entire application
     default = false
     */
    private var disableEntireUserInteraction: Bool? {
        didSet {
            if disableEntireUserInteraction == true {
                UIApplication.shared.beginIgnoringInteractionEvents()
            }
        }
    }
    /**
     Container for spinner
     */
    private var viewActivitySquare: UIView?
    /**
     Indicates if animations is running
    */
    private var isAnimating: Bool?
    /**
     Indicates a lineWidth start with 4.0
     */
    private var lineWidth: CGFloat = 4.0
    /**
     Indicates a defaultFrame start with .zero
     */
    private var defaultFrame: CGRect = .zero
    /**
     Image view for image spinner
     */
    private var imageView: UIImageView?
    /**
     This func Convert degrees in radians
     */
    private func DEGREES_TO_RADIANS(degrees: Double) -> CGFloat {
        return CGFloat(((pi * degrees) / 180))
    }
    /**
     This func configure frames, line width and anchor besed on spinnerSize
     */
    private func configure() {
        if let spinnerSize = spinnerSize {
            guard let spinnerSizeType = SpinnerSize.init(rawValue: spinnerSize.rawValue) else { return }
            switch spinnerSizeType {
            case .MLSpinnerSizeMini:
                frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                defaultFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
                lineWidth = 2.0
            case .MLSpinnerSizeSmall:
                frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                defaultFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
                lineWidth = 4.0
            case .MLSpinnerSizeMedium:
                frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                defaultFrame = CGRect(x: 0, y: 0, width: 82, height: 82)
                lineWidth = 8.0
            case .MLSpinnerSizeLarge:
                frame = CGRect(x: 0, y: 0, width: 185, height: 185)
                defaultFrame = CGRect(x: 0, y: 0, width: 120, height: 120)
                lineWidth = 10.0
            case .MLSpinnerSizeVeryLarge:
                frame = CGRect(x: 0, y: 0, width: 220, height: 220)
                defaultFrame = CGRect(x: 0, y: 0, width: 150, height: 150)
                lineWidth = 12.0
            }
            heightAnchor.constraint(equalToConstant: frame.height).isActive = true
            widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        }
        if spinnerGradientColors == nil {
            spinnerGradientColors = [(spinnerColor?.cgColor)!,
                                     (spinnerColor)!.withAlphaComponent(0.5).cgColor,
                                     (spinnerColor)!.withAlphaComponent(0.25).cgColor,
                                     (spinnerColor)!.withAlphaComponent(0.0).cgColor]
        }
    }
    /**
     This func create a CABasicAnimation for rotation animation
     */
    @objc private func rotationAnimation() {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = NSNumber(value: 0.0)
        rotate.toValue = NSNumber(value: 6.2)
        rotate.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        rotate.duration = 1.5
        viewActivitySquare?.layer .add(rotate, forKey: "rotateRepeatedly")
    }
    /**
     This func create a CAGradientLayer

     - Parameter frame: CGRect
     - returns: An CAGradientLayer
     */
    private func createGradientLayer(frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = spinnerGradientColors!
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }
    /**
     This func create a CAShapeLayer

     - Parameter path: UIBezierPath arc
     - returns: An CAShapeLayer
     */
    private func createShapeLayer(path: UIBezierPath) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineCap = CAShapeLayerLineCap.round
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = lineWidth
        return shape
    }
    /**
     This func start animation and add observer
     */
    open func startAnimating() {
        configure()
        viewActivitySquare = UIView(frame: defaultFrame)
        let lowerPath = UIBezierPath(arcCenter: (viewActivitySquare?.center)!,
                                     radius: (viewActivitySquare?.frame.size.width)! / 2.2,
                                     startAngle: DEGREES_TO_RADIANS(degrees: -5),
                                     endAngle: DEGREES_TO_RADIANS(degrees: angleSpinner),
                                     clockwise: true)

        let lowerShape = self.createShapeLayer(path: lowerPath)
        let gradientLayer = createGradientLayer(frame: defaultFrame)
        gradientLayer.mask = lowerShape
        viewActivitySquare?.layer.addSublayer(gradientLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(rotationAnimation),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)

        viewActivitySquare?.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        if let spinnerImage = spinnerImage {
            createSpinnerWith(spinnerImage: spinnerImage)
        }
        self.addSubview(viewActivitySquare!)
        self.rotationAnimation()
        UIView.animate(withDuration: (stopShowingAndDismissingAnimation == true) ? 0.0 : 0.5) { () -> Void in
            self.alpha = 1.0
        }
    }
    /**
     This function crate a UIImageView, draw image on center and addSubview in viewActivitySquare

     - Parameter spinnerImage: UIImage
     */
    private func createSpinnerWith(spinnerImage: UIImage) {
        guard let viewActivity = viewActivitySquare else { return }
        imageView = UIImageView(image: spinnerImage)
        imageView?.frame = defaultFrame
        viewActivity.addSubview(imageView!)
        imageView?.center = CGPoint(x: viewActivity.frame.size.width / 2,
                                    y: viewActivity.frame.size.height / 2)
    }
    /**
     This func stop animation and remove observer
     */
    open func stopAnimating() {
        UIView.animate(withDuration: (stopShowingAndDismissingAnimation == true) ? 0.0 : 0.5, animations: { () -> Void in
            self.alpha = 0.0
        }) { (finished) -> Void in
            if (finished == true) {
                self.isAnimating = false
                for view: UIView in self.subviews {
                    view.removeFromSuperview()
                }
                if (self.disableEntireUserInteraction == true) {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
            }
        }
    }
}
