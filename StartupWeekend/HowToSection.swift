//
//  HowToSection.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/31/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit
import XTable

func howToSection() -> Section {
    return Section { section in
        section.rows = [
            howToRow(title: "Tell me about Startup Weekend.", image: nil),
            howToRow(title: "What's the competion?", image: nil),
            howToRow(title: "Who are the judges?", image: nil),
            howToRow(title: "Can you help me with my pitch deck?", image: nil)
        ]
    }
}

func howToRow(title: String?, image: UIImage?) -> Row {
    return Row { row in
        row.cell = Cell { cell in
            cell.textLabel?.text = title
            cell.imageView?.image = image
        }
    }
}


