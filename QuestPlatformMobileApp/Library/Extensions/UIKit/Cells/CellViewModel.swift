//
//  CellViewModels.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 10/12/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - View Model Protocols

public protocol AnyCellViewModel {
    static var cellType: UIView.Type { get }
    func setup(cell: UIView)
}

public protocol CellViewModel: AnyCellViewModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}
extension CellViewModel {
    static var cellType: UIView.Type {
        return CellType.self
    }
    func setup(cell: UIView) {
        self.setup(cell: cell as! CellType)
    }
}

// MARK: - Table View

extension UITableView {
    
    /// Use AnyCellViewModel, because CellViewModel type can be used only as generic constraint (because it has associatedtype)
    public func dequeueReusableCell(withModel viewModel: AnyCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: type(of: viewModel).cellType)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        viewModel.setup(cell: cell)
        return cell
    }
    
    public func register(nibModels: [AnyCellViewModel.Type]) {
        for model in nibModels {
            let identifier = String(describing: model.cellType)
            let nib = UINib(nibName: identifier, bundle: nil)
            register(nib, forCellReuseIdentifier: identifier)
        }
    }
}

// MARK: - Collection View

extension UICollectionView {
    
    public func dequeueReusableCell(withModel viewModel: AnyCellViewModel, for indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: type(of: viewModel).cellType)
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        viewModel.setup(cell: cell)
        return cell
    }
    
    public func register(nibModels: [AnyCellViewModel.Type]) {
        for model in nibModels {
            let identifier = String(describing: model.cellType)
            let nib = UINib(nibName: identifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: identifier)
        }
    }
}
