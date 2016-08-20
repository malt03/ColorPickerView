//
//  ViewController.swift
//  ColorPickerView
//
//  Created by Koji Murata on 04/06/2016.
//  Copyright (c) 2016 Koji Murata. All rights reserved.
//

import UIKit
import ColorPickerView

class ViewController: UIViewController, ColorPickerViewDelegate {

  @IBOutlet weak var pickerView: ColorPickerView! {
    didSet {
      pickerView.delegate = self
    }
  }
  
  func colorPicker(_ colorPicker: ColorPickerView, didPickColor color: UIColor, touchPoint point: CGPoint) {
    view.backgroundColor = color
  }
}
