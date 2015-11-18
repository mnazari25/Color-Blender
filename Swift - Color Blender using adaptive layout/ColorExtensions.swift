//
//  ColorExtensions.swift
//  Swift - Color Blender using adaptive layout
//
//  Created by Mirabutaleb Nazari on 2/12/15.
//  Copyright (c) 2015 Bug Catcher Studios. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	
	func RGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		
		// Basically an array of CGFloats
		let intensities = CGColorGetComponents(self.CGColor)
		
		// return Tuple
		return (intensities[0], intensities[1], intensities[2], intensities[3])
		
	}
	
}

extension CGColor {
	
	func RGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		
		// Basically an array of CGFloats
		let intensities = CGColorGetComponents(self)
		
		// return Tuple
		return (intensities[0], intensities[1], intensities[2], intensities[3])
		
	}
	
}