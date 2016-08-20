//
//  ColorPickerView.swift
//  Pods
//
//  Created by Koji Murata on 2016/04/06.
//
//

import UIKit
import ImageColorPicker

public protocol ColorPickerViewDelegate: class {
  func colorPicker(_ colorPicker: ColorPickerView, didPickColor color: UIColor, touchPoint point: CGPoint)
}

open class ColorPickerView: UIImageView {
  open var color = UIColor.clear
  
  @IBInspectable open var topTouchableInset: CGFloat = 0
  @IBInspectable open var leftTouchableInset: CGFloat = 0
  @IBInspectable open var bottomTouchableInset: CGFloat = 0
  @IBInspectable open var rightTouchableInset: CGFloat = 0
  @IBInspectable open var topPickableInset: CGFloat = 0
  @IBInspectable open var leftPickableInset: CGFloat = 0
  @IBInspectable open var bottomPickableInset: CGFloat = 0
  @IBInspectable open var rightPickableInset: CGFloat = 0
  @IBInspectable open var forcePointX: CGFloat = -1 // 0.0 - 1.0 or minus value means nil
  @IBInspectable open var forcePointY: CGFloat = -1 // 0.0 - 1.0 or minus value means nil
  
  open weak var delegate: ColorPickerViewDelegate?
  
  private var isPicking = false
  private var picker = ImageColorPicker()
  
  override open var image: UIImage? {
    get { return super.image }
    set {
      super.image = newValue
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
  
  open func getPoint(_ color: UIColor) -> CGPoint? {
    for x in 0..<Int(bounds.width) {
      for y in 0..<Int(bounds.height) {
        var p = CGPoint(x: x, y: y)
        let c = colorPickFromPicker(&p)
        if c.cgColor == color.cgColor {
          delegate?.colorPicker(self, didPickColor: color, touchPoint: p)
          return p
        }
        if forcePointY >= 0 { break }
      }
      if forcePointX >= 0 { break }
    }
    return nil
  }
  
  open func pick(_ point: CGPoint) {
    var p = point
    color = colorPickFromPicker(&p)
    delegate?.colorPicker(self, didPickColor: color, touchPoint: p)
  }
  
  // MARK: 初期化
  private func initForColorPicker() {
    isUserInteractionEnabled = true
    picker.setImage(image)
  }
  
  // MARK: カラーピック
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    isPicking = true
    pick(touches.first!.location(in: self))
  }
  
  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    pick(touches.first!.location(in: self))
  }
  
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    isPicking = false
  }
  
  override open func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
    isPicking = false
  }
  
  private func colorPickFromPicker(_ point: inout CGPoint) -> UIColor {
    point.x = forcePointX >= 0 ? forcePointX * bounds.width : point.x
    point.y = forcePointY >= 0 ? forcePointY * bounds.height : point.y
    point.x = min(max(point.x, leftPickableInset), bounds.width - rightPickableInset)
    point.y = min(max(point.y, topPickableInset), bounds.height - bottomPickableInset)
    return picker.pick(&point)!
  }
  
  override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    if isPicking {
      return true
    }
    var rect = bounds
    rect.origin.x += leftTouchableInset
    rect.origin.y += topTouchableInset
    rect.size.width -= (leftTouchableInset + rightTouchableInset)
    rect.size.height -= (topTouchableInset + bottomTouchableInset)
    return rect.contains(point)
  }
}
