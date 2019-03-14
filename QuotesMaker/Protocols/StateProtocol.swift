//
//  StateProtocol.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 14/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation


protocol StateUndoProtocol {
    func stateUndo()
}

protocol StateRedoProtocol {
    func stateRedo()
}

typealias StateChangeable = StateUndoProtocol & StateRedoProtocol


