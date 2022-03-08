//
//  HomeViewModel.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit


public protocol Model: Codable { }

public protocol ItemType { }

public protocol Row { }

public struct TVRow: Row {
    public var type: ItemType
    public var model: Model?
    public var selected: Bool
    public var cell: UITableViewCell
    
    public init(type: ItemType, cell: UITableViewCell) {
        self.type = type
        self.cell = cell
        self.model = nil
        self.selected = false
    }
    
    public init(type: ItemType, model: Model, cell: UITableViewCell) {
        self.type = type
        self.cell = cell
        self.model = model
        self.selected = false
    }
    
    public init(type: ItemType, model: Model, selected: Bool, cell: UITableViewCell) {
        self.type = type
        self.cell = cell
        self.model = model
        self.selected = selected
    }
    
    public static func == (lhs: TVRow, rhs: TVRow) -> Bool {
        return lhs.cell == rhs.cell
    }
}




protocol HomeVMVMDelegate: AnyObject {
    func listUpdated(_ list:[TVRow])
}

final class HomeVM {
    weak var delegate: HomeVMVMDelegate?
    private var rows: [TVRow] = []
    enum RowType: ItemType {
        case caption
        case separator
        case border
        case title
        case list
    }
 
    deinit { Log.info() }
}
extension HomeVM {
    func LoadData(){
        setupdata()
    }
    
    private func setupdata(){
        defer { delegate?.listUpdated(rows)}
         rows = []
        
        for i in 0..<50 {
            rows.append(TVRow(.list, cell: TestCell(item: i)))
        }
    }
}
fileprivate extension TVRow {
    init(_ type: HomeVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}




class TestCell : UITableViewCell, Reusable {
    
    let imageSlider = UIImageView()
    
    public init(item: Int){
        super.init(style: .default, reuseIdentifier: TestCell.nibName)
        backgroundColor = .clear
        selectionStyle = .none
        setsdfdf(item: item)
    }
    
    func setsdfdf(item: Int){
        addSubview(imageSlider)
        if item % 2 == 0 {
            
            imageSlider.backgroundColor = .blue
        }else {
            
            imageSlider.backgroundColor = .red
        }
        imageSlider.contentMode = .scaleAspectFill
        imageSlider.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageSlider.translatesAutoresizingMaskIntoConstraints = false
        imageSlider.size(width:100,height: 100)
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
