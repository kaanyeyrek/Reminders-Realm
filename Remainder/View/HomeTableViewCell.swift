//
//  HomeTableViewCell.swift
//  Remainder
//
//  Created by Kaan Yeyrek on 10/26/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"

    private let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .orange
        view.layer.masksToBounds = true
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(view)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     override func prepareForReuse() {
        label.text = nil
        dateLabel.text = nil
    }

     override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = CGRect(x: 20, y: 12, width: 5, height: 40)
        label.frame = CGRect(x: view.right + 10, y: -5, width: contentView.width, height: contentView.height)
        dateLabel.frame = CGRect(x: view.right + 10, y: 25, width: contentView.width, height: contentView.height)
    }

    public func configure(with model: RemainderModel) {
        label.text = model.title
        dateLabel.text = .date(with: model.date)
    }

}
