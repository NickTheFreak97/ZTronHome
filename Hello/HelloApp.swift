//
//  HelloApp.swift
//  Hello
//
//  Created by Niccolo Della Rocca on 09/09/24.
//

import SwiftUI
import ZTronDataModel
import ZTronSerializable

@main
struct HelloApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Memory charms")
        }
    }
}


fileprivate class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            try DBMS.make()
                                    
            do {
                try DBMS.transaction(#function) { dbConnection in
                    
                    let fk = EmptyFK()
                    let studios = makeAllStudios()
                    
                    try studios.writeIfNotExists(db: dbConnection, with: fk, shouldValidateFK: true, propagate: true)
                    return .commit
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        return true
    }
}
