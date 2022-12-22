//
//  didSwipeCellProtocol.swift
//  
//
//  Created by Nikita  on 12/23/22.
//

import Foundation

protocol DidSwipeCellDelegate{
    func didSwipedCell(cell: CustomTableViewCell, direction: Direction) -> ()
}
