//
//  MainScreen2.swift
//  testAssignment App 1
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit
import CoreData

protocol PassData {
	func transferData(text: String)
}


class MainScreen2: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
	
	private var button = CustomButton()
	private var textField = UITextField()
	private let defaults = UserDefaults()
	
	var delegate: PassData?
	
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "LabelSaver")
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				fatalError("Loading of store failed \(error)")
			}
		}
		return container
	}()
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textField.delegate = self
		
		self.title = "Screen 2"
		view.backgroundColor = .white
		view.addGestureRecognizer(setupGestureRecognizer())
		setupView()
		
	}
	private func setupGestureRecognizer() -> UITapGestureRecognizer {
		let gestureRecognizer = UITapGestureRecognizer()
		gestureRecognizer.addTarget(self, action: #selector(viewTapped(gestureRecognizer: )))
		return gestureRecognizer
	}
	
	@objc private func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
		textField.resignFirstResponder()
	}
	
	
	private func setButton() {
		view.addSubview(button)
		button.setTitle("Back", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		button.widthAnchor.constraint(equalToConstant: 200).isActive = true
		button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
	}
	
	private func setupView() {
		view.addSubview(textField)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Enter text"
		textField.autocorrectionType = .no
		textField.keyboardType = .default
		textField.returnKeyType = .continue
		textField.borderStyle = .roundedRect
		textField.textAlignment = .center
		textField.contentVerticalAlignment = .center
		textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
		textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		setButton()
		
	}
	
	fileprivate func delegatePopToRoot() {
		
		if let input = textField.text {
			print(input)
			self.delegate?.transferData(text: input)
			self.navigationController?.popToRootViewController(animated: true)
		}
	}
	
	@objc private func buttonTapped(_ sender: CustomButton) {
		deleteLastLabelFromCoreData()
		
	
		
		closureToRoot { input in
			let rootVC = navigationController?.viewControllers.first as? MainScreen1
			rootVC?.input = input
		}
		navigationController?.popToRootViewController(animated: true)
		
		
		//delegatePopToRoot()
		
//		FIXED POP TO NAVIGATION CONTROLLER
//
//		popToNavigationController()


//		SEGUE TO ROOT VIEW CONTROLLER
//
//		segueToRootViewController()
//
//
//		ONE MORE WAY TO SAVE DATA    --> USER DEFAULTS
//
//		COMMENT OUT CODE BELLOW AND DELETE CODE ABOVE TO CHECK IT
//		ALSO COMMENT OUT METHOD IN VIEW WILL APPEAR IN SCREEN 1

//		userDefaultsToRootController()


//		ONE MORE WAY TO SAVE DATA    --> CORE DATA
//
//		COMMENT OUT CODE BELLOW AND DELETE CODE ABOVE TO CHECK IT
//
//		coreDataToRootViewController()
		
	}
	

	
	
	func closureToRoot(completed: (String?) -> Void) {
		let input = textField.text
		completed(input)
	}
	

	
	private func coreDataToRootViewController() {
		deleteLastLabelFromCoreData()
		saveToCoreData()
		navigationController?.popViewController(animated: true)
	}
	
	
	private func userDefaultsToRootController() {
		let input = textField.text!
		defaults.set(input, forKey: "SavedLabel")
		navigationController?.popViewController(animated: true)
	}
	
	private func segueToRootViewController() {
		let destinationVC = MainScreen1()
		let input = textField.text!
		
		if input == "" { self.navigationController?.popToRootViewController(animated: true) }
		
		destinationVC.input = input
		navigationController?.pushViewController(destinationVC, animated: true)
	}
	
	private func popToNavigationController() {
		let input = textField.text!
		if let rootVC = navigationController?.viewControllers.first as? MainScreen1 {
			rootVC.input = input
		}
		navigationController?.popToRootViewController(animated: true)
	}
	
	
	
	fileprivate func deleteLastLabelFromCoreData() {
		let context = persistentContainer.viewContext
		
		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SavedLabel")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try context.execute(deleteRequest)
		} catch {
			print("Error deleting data ---> \(error.localizedDescription)")
		}
		
	}
	
	fileprivate func saveToCoreData() {
		
		
		let userInput = textField.text!
		
		let context = persistentContainer.viewContext
		let label = NSEntityDescription.insertNewObject(forEntityName: "SavedLabel", into: context) as! SavedLabel
		
		label.text = userInput
		
		do {
			try context.save()
			
		} catch {
			print("Error saving data ---> \(error.localizedDescription)")
		}
	}
	
	
}
