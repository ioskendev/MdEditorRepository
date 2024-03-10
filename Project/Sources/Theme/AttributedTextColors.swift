//
//  AttributedTextColors.swift
//  MdEditor
//
//  Created by Alexey Turulin on 3/9/24.
//  Copyright © 2024 repakuku. All rights reserved.
//

import UIKit
import MarkdownPackage

struct AttributedTextColors: IAttributedTextColors {
	var mainColor: UIColor = Theme.mainColor
	var accentColor: UIColor = Theme.accentColor
}
