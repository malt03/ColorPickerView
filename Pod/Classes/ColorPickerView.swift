//
//  ColorPickerView.swift
//  Pods
//
//  Created by Koji Murata on 2016/04/06.
//
//

import UIKit
import ImageColorPicker

public protocol ColorPickerViewDelegate {
  func colorPicker(colorPicker: ColorPickerView, didPickColor color: UIColor, touchPoint point: CGPoint)
}

public class ColorPickerView: UIImageView {
  public var color = UIColor.clearColor()
  
  @IBInspectable public var topTouchableInset: CGFloat = 0
  @IBInspectable public var leftTouchableInset: CGFloat = 0
  @IBInspectable public var bottomTouchableInset: CGFloat = 0
  @IBInspectable public var rightTouchableInset: CGFloat = 0
  @IBInspectable public var topPickableInset: CGFloat = 0
  @IBInspectable public var leftPickableInset: CGFloat = 0
  @IBInspectable public var bottomPickableInset: CGFloat = 0
  @IBInspectable public var rightPickableInset: CGFloat = 0
  @IBInspectable public var forcePointX: CGFloat = -1 // 0.0 - 1.0 or minus value means nil
  @IBInspectable public var forcePointY: CGFloat = -1 // 0.0 - 1.0 or minus value means nil
  
  public var delegate: ColorPickerViewDelegate?
  
  private var isPicking = false
  private var picker = ImageColorPicker()
  
  override public var image: UIImage? {
    get { return super.image }
    set {
      super.image = image
      initForColorPicker()
    }
  }
  
  override init(image: UIImage?) {
    super.init(image: image)
    initForColorPicker()
  }
  
  override init(image: UIImage?, highlightedImage: UIImage?) {
    super.init(image: image, highlightedImage: highlightedImage)
    initForColorPicker()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initForColorPicker()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initForColorPicker()
  }
  
  public func getPoint(color: UIColor) -> CGPoint? {
    for x in 0..<Int(bounds.width) {
      for y in 0..<Int(bounds.height) {
        var p = CGPoint(x: x, y: y)
        let c = colorPickFromPicker(&p)
        if CGColorEqualToColor(c.CGColor, color.CGColor) {
          delegate?.colorPicker(self, didPickColor: color, touchPoint: p)
          return p
        }
        if forcePointY >= 0 { break }
      }
      if forcePointX >= 0 { break }
    }
    return nil
  }
  
  public func pick(point: CGPoint) {
    var p = point
    color = colorPickFromPicker(&p)
    delegate?.colorPicker(self, didPickColor: color, touchPoint: p)
  }
  
  // MARK: 初期化
  private func initForColorPicker() {
    userInteractionEnabled = true
    picker.setImage(image)
  }
  
  // MARK: カラーピック
  override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    isPicking = true
    pick(touches.first!.locationInView(self))
  }
  
  override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    pick(touches.first!.locationInView(self))
  }
  
  override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    isPicking = false
  }
  
  override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    isPicking = false
  }
  
  private func colorPickFromPicker(inout point: CGPoint) -> UIColor {
    point.x = forcePointX >= 0 ? forcePointX * bounds.width : point.x
    point.y = forcePointY >= 0 ? forcePointY * bounds.height : point.y
    point.x = min(max(point.x, leftPickableInset), bounds.width - rightPickableInset)
    point.y = min(max(point.y, topPickableInset), bounds.height - bottomPickableInset)
    return picker.pick(&point)!
  }
  
  override public func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    if isPicking {
      return true
    }
    var rect = bounds
    rect.origin.x += leftTouchableInset
    rect.origin.y += topTouchableInset
    rect.size.width -= (leftTouchableInset + rightTouchableInset)
    rect.size.height -= (topTouchableInset + bottomTouchableInset)
    return CGRectContainsPoint(rect, point)
  }
}
