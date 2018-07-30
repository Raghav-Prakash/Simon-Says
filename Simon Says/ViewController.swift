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
	
	//MARK: - View Loaded. Sort collection outlets and set initial button text and colorButtons opaqueness.
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sortOutletCollections()
		setInitAlpha()
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
	func setInitAlpha() {
		actionButton.setTitle("Start Game", for: .normal)
		for colorButton in colorButtons {
			colorButton.alpha = 0.5
		}
	}
	
	//MARK: - Color buttons Pressed
	@IBAction func colorButtonsPressed(_ sender: CircularButtons) {
		print("Button with tag \(sender.tag) pressed")
	}
	
	//MARK: - Action button pressed
	@IBAction func actionButtonPressed(_ sender: UIButton) {
		print("Color buttons order: \(colorButtons[0].tag), \(colorButtons[1].tag), \(colorButtons[2].tag), \(colorButtons[3].tag)")
		print("Player Labels order: \(playerLabels[0].tag), \(playerLabels[1].tag)")
		print("Score Labels order: \(scoreLabels[0].tag), \(scoreLabels[1].tag)")
	}
}

