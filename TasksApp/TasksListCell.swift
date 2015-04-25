//
//  TasksListCell.swift
//  TasksApp
//
//  Created by Dominic Furano on 4/17/15.
//  Copyright (c) 2015 Dominic Furano. All rights reserved.
//

import UIKit

class TasksListCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()

        textLabel?.backgroundColor = UIColor.clearColor()
        textLabel?.textColor = UIColor.whiteColor()
        
        detailTextLabel?.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(context)
        CGContextAddPath(context, CGPathCreateWithRoundedRect(rect, 10, 10, nil))
        CGContextClosePath(context)
        
        //CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillPath(context)
    }
    
    
}
