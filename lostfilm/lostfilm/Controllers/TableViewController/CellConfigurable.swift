//
//  CellConfigurable.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 12.12.21.
//

import Foundation

protocol CellConfigurable: UITableViewCell{
    associatedtype DataModel: LFJsonObject
    func configureWith(dataModel: DataModel)
}
