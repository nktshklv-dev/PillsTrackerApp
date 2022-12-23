//
//  CellButtonTappedDelegate.swift
//  Pills Tracker App
//
//  Created by Nikita  on 12/23/22.
//

import Foundation
import UIKit


protocol CellSwipeButtonDelegate{
    func didTapDeleteButton(_ sender: UIButton)
    func didTapAcceptButton(_ sender: UIButton)
}
