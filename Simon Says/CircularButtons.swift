//
//  CircularButtons.swift
//  Simon Says
//
//  Created by Raghav Prakash on 7/30/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import UIKit

class CircularButtons: UIButton {

	//MARK: - When interface builder is loaded to view, set the cornerRadius for the buttons
	override func awakeFromNib() {
		layer.cornerRadius = frame.size.width/2.0
		layer.masksToBounds = true
	}
	
	//MARK: - When a color button is tapped/pressed, when highlighted, set opaqueness to 100%.
	override var isHighlighted: Bool {
		didSet {
			if isHighlighted {
				alpha = 1.0
			} else {
				alpha = 0.5
			}
		}
	}
}
