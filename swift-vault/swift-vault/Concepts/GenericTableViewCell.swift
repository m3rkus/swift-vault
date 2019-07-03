//
//  GenericTableViewCell.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

final class GenericTableViewCell<View: UIView>: UITableViewCell {
    
    var cellContentView: View? {
        didSet {
            setupViews()
        }
    }
    
    private func setupViews() {
        guard let view = cellContentView else { return }
        contentView.add(subviews: view)
        view.constrainEdges(to: contentView)
    }
}
