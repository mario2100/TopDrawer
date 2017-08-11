//
//  FolderRuleCollectionViewItem.swift
//  MenuNav
//
//  Created by Steve Barnegren on 09/08/2017.
//  Copyright © 2017 SteveBarnegren. All rights reserved.
//

import Cocoa
import SBAutoLayout

protocol RuleCollectionViewItemDelegate: class {
    func ruleCollectionViewItemEditPressed(item: RuleCollectionViewItem)
    func ruleCollectionViewItemDeletePressed(item: RuleCollectionViewItem)
}

class RuleCollectionViewItem: NSCollectionViewItem {
    
    // MARK: - Properties
    
    @IBOutlet weak fileprivate var conditionsStackView: NSStackView!
    @IBOutlet weak fileprivate var editButton: NSButton!
    @IBOutlet weak fileprivate var deleteButton: NSButton!

    weak var delegate: RuleCollectionViewItemDelegate?
    
    // MARK: - Configure
    
    func configure<T: Rule>(withRule rule: T,
                   conditionHeight: CGFloat,
                   conditionSpacing: CGFloat) {
        
        conditionsStackView.subviews.forEach{
            $0.removeFromSuperview()
        }
        //conditionsStackView.spacing = conditionSpacing
        
        rule.conditions.forEach{

            let label = NSTextField.createWithLabelStyle()
            label.stringValue = $0.displayDiscription
            conditionsStackView.addArrangedSubview(label)
            //label.pinHeight(conditionHeight)
        }
        
        view.needsLayout = true
    }
    
    
    // MARK: - NSCollectionViewItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.orange.cgColor
        
        editButton.target = self
        editButton.action = #selector(editButtonPressed(sender:))
    }
    
    // MARK: - Actions
    
    @IBAction private func editButtonPressed(sender: NSButton){
        print("Edit button pressed")
        delegate?.ruleCollectionViewItemEditPressed(item: self)
    }
    
    @IBAction private func deleteButtonPressed(sender: NSButton){
        print("Delete button pressed")
        delegate?.ruleCollectionViewItemDeletePressed(item: self)
    }
    
}
