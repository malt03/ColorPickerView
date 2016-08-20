# ColorPickerView

[![Platform](https://img.shields.io/cocoapods/p/ColorPickerView.svg?style=flat)](http://cocoapods.org/pods/ColorPickerView)
![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?ColorPickerViewstyle=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/ColorPickerView.svg?style=flat)](http://cocoapods.org/pods/ColorPickerView)
![License](https://img.shields.io/github/license/malt03/ColorPickerView.svg?style=flat)

## Usage

### Initialize
```swift
@IBOutlet weak var pickerView: ColorPickerView! {
  didSet { pickerView.delegate = self }
}
```

### Pick
```swift
func colorPicker(colorPicker: ColorPickerView, didPickColor color: UIColor, touchPoint point: CGPoint) {
  view.backgroundColor = color
}
```

## Installation via Carthage

ColorPickerView is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "malt03/ColorPickerView"
```

## Installation via CocoaPods

ColorPickerView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ImageColorPicker', git: 'https://github.com/malt03/ImageColorPicker.git', tag: '0.2.0-beta1'
pod "ColorPickerView"
```

## Author

Koji Murata, malt.koji@gmail.com

## License

ColorPickerView is available under the MIT license. See the LICENSE file for more info.
