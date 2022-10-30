//
//  RemainderViewController.swift
//  Remainder
//
//  Created by Kaan Yeyrek on 10/28/22.
//

import UIKit
import RealmSwift

class SelectedRemainderViewController: UIViewController {
    
    private let realm = try! Realm()
    public var item: RemainderModel?
    public var deletionHandler: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.numberOfLines = 1
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.numberOfLines = 1
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        titleLabel.text = item?.title
        dateLabel.text = .date(with: item!.date)
        setup()
        
    }
    func setup() {
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.frame = CGRect(x: 20, y: (view.height-50)/5, width: view.width-30, height: 55)
        dateLabel.frame = CGRect(x: 20, y: titleLabel.bottom+10, width: (view.width-15)/2, height: 100)
        
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }

}
