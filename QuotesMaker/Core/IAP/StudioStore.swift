//
//  StudioStore.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/06/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation
import StoreKit

public typealias ProductsRequestCompletionHandler = (_ success:Bool, _ product:[SKProduct]?, _ error:Error?) -> ()


public class Store:NSObject{
    static let PRO_STUDIO = "com.codesworth.iap.studiopro"
    static let nonConsumableIds:Set<String> = [
        PRO_STUDIO
    ]
    
    public private (set) var hasProduct = false
    
    public private (set) var studioProProduct:SKProduct?{
        didSet{
            hasProduct = studioProProduct != nil
        }
    }
    
    private static let _main = Store()
    
    public static var main:Store{
        return _main
    }
    
    private override init() {
        purchasedProducts = Store.nonConsumableIds.filter{
            KeychainWrapper.standard.bool(forKey: $0) ?? false
        }
        super.init()
    }
    
    fileprivate var productsRequest:SKProductsRequest?
    private var handler:ProductsRequestCompletionHandler?
    public var purchasedProducts = Set<String>()
    
    func handlePurchase(purchaseIdentifier:String){
        if Store.nonConsumableIds.contains(purchaseIdentifier){
            purchasedProducts.insert(purchaseIdentifier)
        }
    }
    
    func restorePurchase(){
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @inline( __always)
    static func isPro()->Bool{
        return main.purchasedProducts.contains(PRO_STUDIO)
    }
    
    func getStudioProProduct(){
        requestProProduct { (_, products,_) in
            let product = products?.first(where: {$0.productIdentifier == Store.PRO_STUDIO})
            if let product = product{self.studioProProduct = product}
        }
    }
}


extension Store{
    
    func buyProduct(product:SKProduct){
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func requestProProduct(handler:@escaping ProductsRequestCompletionHandler){
        productsRequest?.cancel()
        self.handler = handler
        productsRequest = SKProductsRequest(productIdentifiers: Store.nonConsumableIds)
        productsRequest?.delegate = self
        productsRequest?.start()
        
    }
}


extension Store:SKProductsRequestDelegate{
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        handler?(true,response.products,nil)
        handler = .none
        productsRequest = .none
        
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        handler?(false,nil,error)
        handler = .none
        productsRequest = .none
        print("Unable to Look up items with error: \(error.localizedDescription)")
    }
    
}
