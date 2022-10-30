//
//  ViewController.swift
//  Remainder
//
//  Created by Kaan Yeyrek on 10/25/22.
//

import RealmSwift
import UIKit

class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return table
        // hey
    }()

    private let realm = try! Realm()

    private var data = [RemainderModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(RemainderModel.self).map({ $0 })
        title = "Remainders"
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", image: UIImage(systemName: "plus.circle"), target: self, action: #selector(didTapAddButton))
        navigationController?.navigationBar.prefersLargeTitles = true
        setup()
    }

    @objc private func didTapAddButton() {
        let vc = EntryViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.title = "Add Your Event"
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
    }

    func setup() {
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let model = data[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        let vc = SelectedRemainderViewController()
        vc.item = item
        vc.title = item.title
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func refresh() {
        data = realm.objects(RemainderModel.self).map({ $0 })
        tableView.reloadData()
    }
}

