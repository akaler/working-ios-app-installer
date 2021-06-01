//
//  LoginViewController.swift
//  adb-ios
//
//  Created by Abhijot Kaler on 5/30/21.
//  Copyright © 2021 Li Zonghai. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        struct login_response: Codable {
            var authentication_token: String?
            var id: Int?
            //var roles: String?
        }
        
        
        let Url = String(format: "http://127.0.0.1:5000/auth/login")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                        "email" : "regular_user",
                        "password": "123"
                
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print("printing response")
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                       //let decoder = JSONDecoder()
                        
                        //let result = try decoder.decode([String: login_response].self, from:data)
                        print(json)
                        if let dictionary = json as? [String: Any] {
                            let DUID_STRING = dictionary["authentication_token"]
                            print("Printing DUID_STRING line60")
                            print(DUID_STRING as! String)
                        }
                        
                        
                        print("gonna print the authentication token again:")
                        print(json)
                        
                        //print(json["authentication_token"])
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        
        // sending DUID now

        print("sending DUID now")
        //send_duid()
        
        
        
        
        }
    
    
    @IBAction func sendDuid(_ sender: Any) {
        send_duid()
    }
    

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




func send_duid() {
    //sends duid to the backend servers
    let Url = String(format: "http://127.0.0.1:5000/user/duid")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] = [
                    "duid" : "23984320984039284",
        ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("printing response")
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                   //let decoder = JSONDecoder()
                    
                    //let result = try decoder.decode([String: login_response].self, from:data)
                    
                    
                    print(json)
                    
                    //print(json["authentication_token"])
                } catch {
                    print(error)
                }
            }
        }.resume()
}

func retrieve_tpk()
{
    let Url = String(format: "https://unite.healthscitech.org/api/user/files/:duid")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters: [String: Any] = [
                    "duid" : "23984320984039284",
        ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("printing response")
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                   //let decoder = JSONDecoder()
                    
                    //let result = try decoder.decode([String: login_response].self, from:data)
                    
                    
                    print(json)
                    
                    //print(json["authentication_token"])
                } catch {
                    print(error)
                }
            }
        }.resume()
    
}





















extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
