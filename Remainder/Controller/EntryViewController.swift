//
//  EntryViewController.swift
//  Remainder
//
//  Created by Kaan Yeyrek on 10/26/22.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Add your title..."
        field.returnKeyType = .done
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = .now
        datePicker.locale = .current

        return datePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        field.becomeFirstResponder()
        field.delegate = self
        datePicker.setDate(Date(), animated: true)
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
    }
    func setup() {
        view.addSubview(field)
        view.addSubview(datePicker)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        field.frame = CGRect(x: 20, y: (view.height-50)/5, width: view.width-30, height: 55)
        datePicker.frame = CGRect(x: 20, y: field.bottom+10, width: (view.width-15)/2, height: 100)
      
        
    }
    @objc private func didTapCancel() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.tabBarController?.selectedIndex = 0
        }
    @objc private func didTapSave() {
        guard let field = field.text, !field.isEmpty else {
                return
            }
        let date = datePicker.date
        
        realm.beginWrite()
        let newItem = RemainderModel()
        newItem.date = date
        newItem.title = field
        realm.add(newItem)
        
        try! realm.commitWrite()
        completionHandler?()
        navigationController?.popToRootViewController(animated: true)

        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
    }

    }

