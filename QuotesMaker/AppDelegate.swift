//
//  AppDelegate.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 24/02/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import StoreKit
let APP_RUN_FIRSTTIME = "firstRun"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    var window: UIWindow?
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        let idiom = UIDevice.idiom
//        if idiom == .pad{
//            return .landscape
//        }else{
//            return .portrait
//        }
//    }
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let alreadyRun = KeychainWrapper.standard.bool(forKey: APP_RUN_FIRSTTIME) ?? false
        if !alreadyRun{
            KeychainWrapper.standard.set(false, forKey: Store.PRO_STUDIO)
            KeychainWrapper.standard.set(true, forKey: APP_RUN_FIRSTTIME)
        }
            Persistence.main.createDirectories()
          //  UserDefaults.standard.set(true, forKey: "first")
        //}
//        let idiom = UIDevice.current.userInterfaceIdiom
//        if idiom == .pad{
//            window?.rootViewController = iPadStudioVC()
//        }
        setRootViewContoroller()
        Store.main.getStudioProProduct()
        Cloudstore().fetAvailableModel()
//        for family: String in UIFont.familyNames
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
        SKPaymentQueue.default().add(self)
        let appearance = UIBarButtonItem.appearance()
        appearance.tintColor = .primary
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setRootViewContoroller(){
        if UIDevice.idiom == .phone{
            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
            window?.rootViewController = home
        }
    }
}

extension AppDelegate:SKPaymentTransactionObserver{
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions{
            switch transaction.transactionState{
            case .purchased, .restored:
                completeTransaction(transaction)
                break
            case .failed:
                failedTransaction(transaction)
                break
            default:
                break
            }
        }
    }
    
    func completeTransaction(_ transaction:SKPaymentTransaction){
        KeychainWrapper.standard.set(true, forKey: transaction.payment.productIdentifier)
        deliverPurchaseNotification(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }
    
    func failedTransaction(_ transaction:SKPaymentTransaction){
        if let transactionError = transaction.error as NSError? {
           Subscription.main.post(suscription: .failedPurchase, object:transactionError )
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    
    func deliverPurchaseNotification(identifier:String?){
        guard let identifier = identifier else {return}
        Subscription.main.post(suscription: .purchaseNotification, object: identifier)
        Store.main.handlePurchase(purchaseIdentifier: identifier)
    }
    
}

func printFonts(){
    //print("The fonts are: \(UIFont)")
}



