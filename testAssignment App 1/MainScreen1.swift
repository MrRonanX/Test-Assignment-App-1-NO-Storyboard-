//
//  ViewController.swift
//  testAssignment App 1
//
//  Created by Roman Kavinskyi on 16.06.2020.
//  Copyright © 2020 Roman Kavinskyi. All rights reserved.
//

import UIKit
import CoreData

class MainScreen1: UIViewController {
	
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "LabelSaver")
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				fatalError("Loading of store failed \(error)")
			}
		}
		return container
	}()
	
	
	
	var label = UILabel()
	let defaults = UserDefaults()
	var secondVC = MainScreen2()
	
	private var button = CustomButton()
	var input: String! {
		didSet {
			label.text = input
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()		
		secondVC.delegate = self
		self.title = "Screen 1"
		view.backgroundColor = .white
		
		
		setupView()
		
		
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//setLabelFromDefaults()
		setLabelFromCoreData()
//		secondVC.closureToRoot { (title) in
//			print("Closure called")
//			label.text = title
//		}
		
	}
	
	private func setButton() {
		view.addSubview(button)
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
		navigationController?.pushViewController(secondVC, animated: true)
		
		
		
	}
	
	private func setLabelFromDefaults() {
		
		if let input = defaults.string(forKey: "SavedLabel") {
			label.text = input
		}
	}
	
	private func loadLabelFromCoreData() -> String? {
		
		let context = persistentContainer.viewContext
		
		let fetchRequest = NSFetchRequest<SavedLabel>(entityName: "SavedLabel")
		
		do {
			let labelText = try context.fetch(fetchRequest)
			return labelText.first?.text
		} catch {
			print("Error loading data ---> \(error.localizedDescription)")
		}
		return nil
	}
	
	private func setLabelFromCoreData() {
		if let labelText = loadLabelFromCoreData() {
			label.text = labelText
		}
	}
	
	
}

extension MainScreen1: PassData {
	func transferData(text: String) {
		print("delegate called")
		label.text = text
		}
	}



