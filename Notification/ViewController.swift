//
//  ViewController.swift
//  Notification
//
//  Created by Samet ÇELİKBIÇAK on 24.03.2018.
//  Copyright © 2018 Samet ÇELİKBIÇAK. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bildirimBaslikTextField: UITextField!
    @IBOutlet weak var bildirimDetayTextField: UITextField!
    @IBOutlet weak var bildirimTarihDatePicker: UIDatePicker!
    
    var bildirimSayisi: Int = UserDefaults.standard.integer(forKey: "bildirimSayisi")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func BildirimGonder (title titleText: String, body bodyText:String, date notificationDate:Date) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = titleText
        content.body = bodyText
        content.sound = UNNotificationSound.default()
        content.badge = (self.bildirimSayisi + 1) as NSNumber
        BildirimSayisiArttir(bildirimSayisi: self.bildirimSayisi + 1)
        let trigerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute,], from: notificationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: trigerDate, repeats: false)
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                print("BildirimGonder Hata: \(String(describing: error))")
            }
        }
    }
    
    func BildirimSayisiArttir(bildirimSayisi: Int) {
        if bildirimSayisi > -1 {
            self.bildirimSayisi = bildirimSayisi
            UserDefaults.standard.set(self.bildirimSayisi, forKey: "bildirimSayisi")
        } else {
            UIApplication.shared.applicationIconBadgeNumber = -1
        }
    }
    
    
    @IBAction func bildirimGonder(_ sender: Any) {
        BildirimGonder(title: bildirimBaslikTextField.text!, body: bildirimDetayTextField.text!, date: bildirimTarihDatePicker.date)
    
        let alert = UIAlertController(title: "Bildirim", message: "Bildirim Ayarlandı", preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

