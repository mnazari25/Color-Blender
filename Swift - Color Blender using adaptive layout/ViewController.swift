//
//  ViewController.swift
//  Swift - Color Blender using adaptive layout
//
//  Created by Mirabutaleb Nazari on 2/5/15.
//  Copyright (c) 2015 Bug Catcher Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	/* Color View Outlets */
	@IBOutlet weak var firstColorView: UIView!
	@IBOutlet weak var secondColorView: UIView!
	
	/* Slider Outlets */
	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	
	/* RGB labels */
	@IBOutlet weak var redLabel: UITextField!
	@IBOutlet weak var greenLabel: UITextField!
	@IBOutlet weak var blueLabel: UITextField!
	
	@IBOutlet weak var HexLabel: UILabel!
	
	/* Current View to modify or display info about */
	var currentActiveView : UIView?
	
	/* Blended Outlet Collections */
	@IBOutlet var blendedViewCollection: [UIView]!

	@IBOutlet var blendedViewCollection_D1: [UIView]!
 
	@IBOutlet var blendedViewCollection_L1: [UIView]!
	
	@IBOutlet var blendedViewCollection_D2: [UIView]!
	
	@IBOutlet var blendedViewCollection_L2: [UIView]!
	
	/* View Did Load */
 
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		currentActiveView = firstColorView
		
		/* Add Tap gesture recognizer */
		/* Each view needs unique recognizer */
		
		var tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
		firstColorView.addGestureRecognizer(tapGesture)
		
		TapGestureRecognized(tapGesture)
		
		tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
		secondColorView.addGestureRecognizer(tapGesture)
		
		/* Add tap gestures to blendedviews */
		for var i = 0; i < blendedViewCollection.count; i++ {
			
			tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
			blendedViewCollection[i].addGestureRecognizer(tapGesture)
			
			tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
			blendedViewCollection_D1[i].addGestureRecognizer(tapGesture)
			
			tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
			blendedViewCollection_L1[i].addGestureRecognizer(tapGesture)
			
			tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
			blendedViewCollection_D2[i].addGestureRecognizer(tapGesture)
			
			tapGesture = UITapGestureRecognizer(target: self, action: "TapGestureRecognized:")
			blendedViewCollection_L2[i].addGestureRecognizer(tapGesture)
			
		}
		
		UpdateBlendedViews()

	}
	
	/* Tap Gesture Recognizer */

	func TapGestureRecognized(sender: UITapGestureRecognizer) {
		
		
		print("pressd")
		/* Disable sliders when blend view is current view */
		if let tag = sender.view?.tag {
			
			if tag == 5 {
				
				redSlider.enabled = true
				greenSlider.enabled = true
				blueSlider.enabled = true
				
			} else {
				
				redSlider.enabled = false
				greenSlider.enabled = false
				blueSlider.enabled = false
				
			}
			
		}
		
		
		if let v = currentActiveView {
			
			v.layer.borderWidth = 0
			
		}
		
		/* Set tapped view to current view */
		currentActiveView = sender.view
		currentActiveView?.layer.borderColor = UIColor.whiteColor().CGColor
		currentActiveView?.layer.borderWidth = 3
		
		/* Adjust sliders, Hex Label, and RGB text fields to reflect current selected */
		let intensities = sender.view!.layer.backgroundColor!.RGBA()
		
		redSlider.value = Float(intensities.red)
		greenSlider.value = Float(intensities.green)
		blueSlider.value = Float(intensities.blue)
		
		UpdateHexLabel((red: intensities.red, green: intensities.green, blue: intensities.blue, alpha: intensities.alpha))
		
	}
	
	/* Slider Changed Value */
	
	@IBAction func sliderChangedValue(sender: UISlider) {
		
		if let intensities = currentActiveView?.layer.backgroundColor!.RGBA() {
			
			switch sender.tag {
				
			case 10:
				currentActiveView?.layer.backgroundColor = UIColor(red: CGFloat(sender.value), green: intensities.green, blue: intensities.blue, alpha: 1.0).CGColor
			case 20:
				currentActiveView?.layer.backgroundColor = UIColor(red: intensities.red, green: CGFloat(sender.value), blue: intensities.blue, alpha: 1.0).CGColor
			case 30:
				currentActiveView?.layer.backgroundColor = UIColor(red: intensities.red, green: intensities.green, blue: CGFloat(sender.value), alpha: 1.0).CGColor
			default:
				print("How?")
				
			}
			
			UpdateBlendedViews()
			UpdateHexLabel((red: intensities.red, green: intensities.green, blue: intensities.blue, alpha: intensities.alpha))

		}
		
	}
	
	
	func UpdateHexLabel(colors: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)) {
		
		let _red = Int(colors.red * 255)
		let _green = Int(colors.green * 255)
		let _blue = Int(colors.blue * 255)
		
		var redFormat = "%2X"
		var greenFormat = "%2X"
		var blueFormat = "%2X"
		
		redLabel.text = "\(_red)"
		greenLabel.text = "\(_green)"
		blueLabel.text = "\(_blue)"
		
		if _red <= 15 {
			
			redFormat = "0%1X"
			
		}
		
		if _green <= 15 {
			
			greenFormat = "0%1X"
			
		}
		
		if _blue <= 15 {
			
			blueFormat = "0%1X"
			
		}
		
		HexLabel.text = "#" + String(format: redFormat, _red) + String(format: greenFormat, _green) + String(format: blueFormat, _blue)
		
	}
	
	func UpdateBlendedViews() {
		
		/* Get Color Values from main color views */
		let color1 = firstColorView.layer.backgroundColor!.RGBA()
		let color2 = secondColorView.layer.backgroundColor!.RGBA()
		
		/* Calculate the Delta(change in value) for each blended view */
		let redDelta = (color1.red - color2.red) / 8
		let greenDelta = (color1.green - color2.green) / 8
		let blueDelta = (color1.blue - color2.blue) / 8
		
		/* Loop through blend views and change colors */
		var _red : CGFloat = 0
		var _green : CGFloat = 0
		var _blue : CGFloat = 0
		
		for var i = 0; i < blendedViewCollection.count; i++ {
			
			_red = color1.red - redDelta * CGFloat(i)
			_green = color1.green - greenDelta * CGFloat(i)
			_blue = color1.blue - blueDelta * CGFloat(i)
			
			blendedViewCollection[i].layer.backgroundColor = UIColor(red: _red, green: _green, blue: _blue, alpha: 1.0).CGColor
			
			blendedViewCollection_D1[i].layer.backgroundColor = UIColor(red: _red - (_red * 0.25), green: _green - (_green * 0.25), blue: _blue - (_blue * 0.25), alpha: 1.0).CGColor
			blendedViewCollection_L1[i].layer.backgroundColor = UIColor(red: _red + (_red * 0.25), green: _green + (_green * 0.25), blue: _blue + (_blue * 0.25), alpha: 1.0).CGColor
			
			blendedViewCollection_D2[i].layer.backgroundColor = UIColor(red: _red - (_red * 0.50), green: _green - (_green * 0.50), blue: _blue - (_blue * 0.50), alpha: 1.0).CGColor
			blendedViewCollection_L2[i].layer.backgroundColor = UIColor(red: _red + (_red * 0.50), green: _green + (_green * 0.50), blue: _blue + (_blue * 0.50), alpha: 1.0).CGColor
			
		}
		
	}

}


