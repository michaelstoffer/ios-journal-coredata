//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Michael Stoffer on 7/10/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - IBOutlets and Properties
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet {
            self.updateViews()
        }
    }
    var entryController: EntryController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        self.toggleSaveButton()
        self.titleTextField.addTarget(self, action: #selector(toggleSaveButton), for: .editingChanged)
    }
    
    // MARK: - IBActions and Methods
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let entryTitle = self.titleTextField.text,
            !entryTitle.isEmpty else { return }
        
        let entryBodyText = self.bodyTextView.text
        
        if let entry = self.entry {
            self.entryController?.updateEntry(withEntry: entry, withTitle: entryTitle, withBodyText: entryBodyText)
        } else {
            self.entryController?.createEntry(withTitle: entryTitle, withBodyText: entryBodyText)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }

        self.title = self.entry?.title ?? "Create Entry"
        self.titleTextField.text = entry?.title
        self.bodyTextView.text = entry?.bodyText
    }
    
    @objc private func toggleSaveButton() {
        self.saveButton.isEnabled = !self.titleTextField.text!.isEmpty
    }
}
