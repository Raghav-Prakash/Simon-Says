//
//  ViewController.swift
//  Simon Says
//
//  Created by Raghav Prakash on 7/30/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	//MARK: - Define outlet collections and outlet
	@IBOutlet var colorButtons: [CircularButtons]!
	@IBOutlet var playerLabels: [UILabel]!
	@IBOutlet var scoreLabels: [UILabel]!
	@IBOutlet weak var actionButton: UIButton!
	
	//MARK: - Define variables for the game functionalities
	var currentPlayer = 0
	var scores = [0,0]
	
	var sequenceIndex = 0
	var colorSequence = [Int]() // Save the color tags to be memorized
	var colorsToTap = [Int]() // Have the saved color tags sequence to check if the tapped sequence matches the actual one.
	
	//MARK: - View Loaded. Sort collection outlets and set initial button text and colorButtons opaqueness.
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sortOutletCollections()
		setUpNewGame()
	}
	
	//MARK: - Sort the collection outlets ([CircularButtons] and the two [UILabel]) based on increasing tags.
	func sortOutletCollections() {
		colorButtons = colorButtons.sorted(by: { (button1, button2) -> Bool in
			return button1.tag < button2.tag
		})
		playerLabels = playerLabels.sorted(by: { (label1, label2) -> Bool in
			return label1.tag < label2.tag
		})
		scoreLabels = scoreLabels.sorted(by: { (label1, label2) -> Bool in
			return label1.tag < label2.tag
		})
	}
	//MARK: - Set the buttons to be 50% opaque (i.e. 50% transparent)
	func setUpNewGame() {
		colorSequence.removeAll()
		
		actionButton.setTitle("Start Game", for: .normal)
		actionButton.isEnabled = true
		
		for colorButton in colorButtons {
			colorButton.alpha = 0.5
			colorButton.isEnabled = false
		}
	}
	
	//MARK: - Generate a new color and save it to our colorSequence array
	func addNewColor() {
		colorSequence.append(Int(arc4random_uniform(UInt32(4))))
	}
	
	//MARK: - Play the sequence for the player to memorize the generated colors
	func playSequence() {
		// Two parts - 1: flash the colors based on the color sequence and 2: have the user tap his memorized color sequence
		if sequenceIndex < colorSequence.count {
			// Part One. Get the color to flash and increment the index
			let colorButtonToFlash = colorButtons[colorSequence[sequenceIndex]]
			flash(colorButtonToFlash: colorButtonToFlash)
			
			sequenceIndex += 1
		} else {
			// Part Two. Re-enable user interaction on the view and re-enable the color buttons.
			actionButton.setTitle("Tap the colors", for: .normal)
			
			colorsToTap = colorSequence
			
			view.isUserInteractionEnabled = true
			enableOrDisableColors(option: "enable")
		}
	}
	//MARK: - Flash the color for the player to memorize
	func flash(colorButtonToFlash: CircularButtons) {
		// For 0.5 seconds, Color button's alpha value is 1.0 then reset to 0.5. This is an animation on the view.
		// Once the animation is completed, we play the sequence again to flash the next color in the color sequence.
		UIView.animate(withDuration: 0.5, animations: {
			colorButtonToFlash.alpha = 1.0
			colorButtonToFlash.alpha = 0.5
		}) { (bool) in
			self.playSequence()
		}
	}
	
	//MARK: - Color buttons Pressed
	@IBAction func colorButtonsPressed(_ sender: CircularButtons) {
		if sender.tag == colorsToTap.removeFirst() {
			
		} else {
			enableOrDisableColors(option: "disable")
			print("Wrong sequence!")
			return
		}
		
		// If the user has tapped every button successfully, the colorsToTap array will be empty
		if colorsToTap.isEmpty {
			print("You got all right!")
			
			enableOrDisableColors(option: "disable")
			actionButton.setTitle("Play Again?", for: .normal)
			actionButton.isEnabled = true
		}
	}
	
	//MARK: - Action button pressed
	@IBAction func actionButtonPressed(_ sender: UIButton) {
		sequenceIndex = 0
		
		actionButton.setTitle("Memorize", for: .normal)
		actionButton.isEnabled = false
		
		view.isUserInteractionEnabled = false // disable any interaction on any part of the view
		
		// Add a new color and after a delay of 1 second, play the color sequence generated so far.
		addNewColor()
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
			self.playSequence()
		}
	}
	
	//MARK: - Enable/Disable color buttons based on the parameter
	func enableOrDisableColors(option: String) {
		
		for colorButton in colorButtons {
			if(option.lowercased() == "enable") {
				colorButton.isEnabled = true
			} else {
				colorButton.isEnabled = false
			}
		}
	}
}

