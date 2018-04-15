//
//  MenuView.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 15.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuViewDelegate: class {
    func menuViewDidSelectProfile(_ menuView: MenuView)
    func menuViewDidSelectMyQuests(_ menuView: MenuView)
    func menuViewDidSelectStartNewQuest(_ menuView: MenuView)
    func menuViewDidSelectAbout(_ menuView: MenuView)
    func menuViewDidSelectLogout(_ menuView: MenuView)
}

final class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    
    
    // MARK: - Views
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        return stackView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        
        stackView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().inset(16)
            maker.centerY.equalToSuperview()
        }
        
        let actions: [MenuItemAction] = [
            MenuItemAction(title: "Profile") { [unowned self] in
                self.delegate?.menuViewDidSelectProfile(self)
            },
            MenuItemAction(title: "My Quests") { [unowned self] in
                self.delegate?.menuViewDidSelectMyQuests(self)
            },
            MenuItemAction(title: "Start New") { [unowned self] in
                self.delegate?.menuViewDidSelectStartNewQuest(self)
            },
            MenuItemAction(title: "About") { [unowned self] in
                self.delegate?.menuViewDidSelectAbout(self)
            },
            MenuItemAction(title: "Sign Out") { [unowned self] in
                self.delegate?.menuViewDidSelectLogout(self)
            },
        ]
        
        actions.forEach { action in
            
            let itemView = MenuItemView()
            itemView.title = action.title
            itemView.selectionHandler = { _ in action.handler() }
            
            stackView.addArrangedSubview(itemView)
            itemView.snp.makeConstraints { maker in
                maker.height.equalTo(44)
            }
        }
    }
}
