//
//  SharedLogger.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import Foundation

public final class SharedLogger {

    static private(set) var privateQueue = DispatchQueue(label: "com.usama.WeatherTask")

    /// Logging Error Message to console
    ///
    /// - Parameter message: String
    public static func logError(_ message: String) {
        if !SharedLogger.isLogEnabled() {
            return
        }
        privateQueue.async {
            print("*********** Error *********** : \(message)")
        }
    }
    /// Logging Info to console
    ///
    /// - Parameter message: String
    public static func logInfo(_ message: String) {
        if !SharedLogger.isLogEnabled() {
            return
        }
        privateQueue.async {
            print(message)
        }
    }
    
    //This method is used to enable and disable log when releasing the app for test or apple store
    public static func isLogEnabled() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    /// Loging Error
    ///
    /// - Parameter error: Error
    public static func logException(_ error: Error) {
        privateQueue.async {
         print((error as NSError).localizedDescription)
        }
    }
}
