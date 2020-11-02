//
//  PushNotificationSender.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 29/10/2020.
//


import UIKit

class PushNotificationSender {
    func sendPushNotification(to userId: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        
        // fetch current token
        FirebaseClient.shared.getUserInfo(uid: userId) { result in
            switch result {
            case .success(let user):
                let paramString: [String : Any] = ["to" : user.deviceToken ?? "",
                                                        "priority" : "high",
                                                        "notification" : ["title" : title, "body" : body],
                                                        "data" : ["user" : ""]
                     ]
                     let request = NSMutableURLRequest(url: url as URL)
                     request.httpMethod = "POST"
                     request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
                     request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                     request.setValue("key=AAAA3ljcf10:APA91bHxy-gkhGS3uB_KniIAYZT_yvuU_PL0mcWWGQ5CCcb2Ia48Py-LhlRAADKuQZecBKwIhOn8palTiRE1LuJKKDU10eF8SaAL_5FX-5SmMRaTrgPj-EfgFKKo0I83buyn51wor_e6", forHTTPHeaderField: "Authorization")
                     let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
                         do {
                             if let jsonData = data {
                                 if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                                     NSLog("Received data:\n\(jsonDataDict))")
                                 }
                             }
                         } catch let err as NSError {
                             print(err.debugDescription)
                         }
                     }
                     task.resume()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

