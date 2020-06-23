//
//  CustomButton.swift
//  testAssignment App 1
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
		
	}
	
	
	private func setupButton() {
		setShadow()
		setTitleColor(.white, for: .normal)
		
		backgroundColor	= .systemTeal
		titleLabel?.font 	= UIFont(name: "Futura-Medium", size: 18)
		layer.cornerRadius = 12
		layer.borderWidth 	= 3.0
		layer.borderColor 	= UIColor.darkGray.cgColor
	}
	
	private func setShadow() {
		layer.shadowColor 		= UIColor.black.cgColor
		layer.shadowOffset 	= CGSize(width: 0, height: 6)
		layer.shadowRadius 	= 8
		layer.shadowOpacity 	= 0.5
		clipsToBounds 			= true
		layer.masksToBounds 	= false
	}
	
	func shake() {
		let shake 			= CABasicAnimation(keyPath: "position")
		shake.duration 		= 0.1
		shake.repeatCount 	= 2
		shake.autoreverses	 	= true
		let fromPoint 		= CGPoint(x: center.x - 8, y: center.y)
		let fromValue		= NSValue(cgPoint: fromPoint)
		
		let toPoint			= CGPoint(x: center.x + 8, y: center.y)
		let toValue			= NSValue(cgPoint: toPoint)
		
		shake.fromValue		= fromValue
		shake.toValue			= toValue
		
		layer.add(shake, forKey: "position")
	}
	
}
