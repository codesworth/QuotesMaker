//
//  Dispatch.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 23/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

typealias MainThreadAsyncBlock = () -> ()

func AsyncOnMainThread(_ block:@escaping MainThreadAsyncBlock){
    DispatchQueue.main.async(execute: block)
}
