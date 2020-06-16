//
//  ViewController.swift
//  testAssignment App 1
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit
protocol MyDelegate: class {
	func delegateButtonTapped()
}

class MainScreen1: UIViewController, MyDelegate {
	
	
    var label = UILabel()
	
    private var button = CustomButton()
	var input: String! {
		didSet {
			label.text = input
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.title = "Screen 1"
        view.backgroundColor = .white
		navigationItem.hidesBackButton = true
        
        setupView()
        
    }
    
	private func setButton() {
		view.addSubview(button)
		button.delegate = self
		button.setTitle("Next Screen", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		button.widthAnchor.constraint(equalToConstant: 200).isActive = true
		button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
	}
	
	private func setupView() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
//		ONE MORE WAY TO SET LABEL
//
//		if let input = input {
//			label.text = input
//		}
        
		setButton()

    }
    
    @objc private func buttonTapped(_ sender: CustomButton) {
		
			self.delegateButtonTapped()
		
		
		
	}
	
	func delegateButtonTapped() {
		let nextViewController = MainScreen2()
		
		
		navigationController?.pushViewController(nextViewController, animated: true)
	}


}

