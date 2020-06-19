//
//  MainScreen2.swift
//  testAssignment App 1
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit
import CoreData


class MainScreen2: UIViewController, MyDelegate, UITextFieldDelegate {
	
	private var button = CustomButton()
	private var textField = UITextField()
	private let defaults = UserDefaults()
	
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
		button.delegate = self
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
	
	@objc private func buttonTapped(_ sender: CustomButton) {
		
			self.delegateButtonTapped()
		
		
		
	}
	
	
	func delegateButtonTapped() {
		deleteLastLabelFromCoreData()
		let destinationVC = MainScreen1()
		let input = textField.text!

		if input == "" { self.navigationController?.popToRootViewController(animated: true) }

		destinationVC.input = input
		navigationController?.pushViewController(destinationVC, animated: true)
		
		
//		ONE MORE WAY TO SAVE DATA    --> USER DEFAULTS
//
//		COMMENT OUT CODE BELLOW AND DELETE CODE ABOVE TO CHECK IT
//
//		let input = textField.text!
//		defaults.set(input, forKey: "SavedLabel")
//		navigationController?.popViewController(animated: true)
		
		
//		ONE MORE WAY TO SAVE DATA    --> CORE DATA
//
//		COMMENT OUT CODE BELLOW AND DELETE CODE ABOVE TO CHECK IT
//
//
//		deleteLastLabelFromCoreData()
//		saveToCoreData()
//		navigationController?.popViewController(animated: true)
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
