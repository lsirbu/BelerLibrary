//
//  ServiceManager.swift
//  MyFramework
//
//  Created by Liliana on 25/01/16.
//  Copyright (c) 2016 Liliana Sirbu. All rights reserved.
//

import UIKit

public class ServiceManager: NSObject {

    /*
    let link = SERVER_ADDRESS + "GetAllPatient"
    let parameters = [
                        "sId"  : sessionId,
                        "d1"    : dateMAJ,
                        "practicianID"    : practicienId]  // build your dictionary however appropriate
    
    self.HTTPGetJSON(link, postDictionary: parameters)
        {
            (data: Dictionary<String, AnyObject>, error: String?) -> Void in
            if (error != nil) {
                println(error!)
            } else {
                //self.savePatientsCoreData(sessionId, data:data)
            }
        }
    */
    
    class public var sharedInstance : ServiceManager {
        
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : ServiceManager? = nil
        }
        
        dispatch_once(&Static.onceToken) {
            Static.instance = ServiceManager()
        }
        
        return Static.instance!
    }

    
    public class func HTTPGetJSON(
        link: String,
        postDictionary: Dictionary<String, AnyObject>?,
        callback: (Dictionary<String, AnyObject>, String?) -> Void) {
            let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
            
            var jsonObj:NSString = ""
            
            if postDictionary != nil {
                for (key, value) in postDictionary! {
                    jsonObj = jsonObj.stringByAppendingString("\(key)=\(value)")
                    jsonObj = jsonObj.stringByAppendingString("&")
                }
                jsonObj = jsonObj.stringByReplacingCharactersInRange(NSMakeRange(jsonObj.length-1, 1), withString: "")
            }
            let jsonString = JSONStringify(jsonObj)
            
            let url = NSURL(string:link)
            
            NSLog("PostData: %@ %@", jsonObj, link);
            
            var postData:NSData = jsonObj.dataUsingEncoding(NSASCIIStringEncoding)!
            
            var postLength:NSString = String( postData.length )
            
            let request = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 60.0)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            HTTPsendRequest(request) {
                (data: String, error: String?) -> Void in
                
                if (error != nil) {
                    callback(Dictionary<String, AnyObject>(), error)
                } else {
                    var jsonObj = self.JSONParseDict(data)
                    
                    callback(jsonObj, nil)
                }
            }
    }
    
    class func JSONStringify(jsonObj: AnyObject) -> String {
        if NSJSONSerialization.isValidJSONObject(jsonObj) {
            if let data = NSJSONSerialization.dataWithJSONObject(jsonObj, options: NSJSONWritingOptions(0), error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    class func HTTPsendRequest(request: NSMutableURLRequest,
        callback: (String, String?) -> Void) {
            println("!!!!!!!!!!HTTPsendRequest!!!!!!!")
            let task = NSURLSession.sharedSession()
                .dataTaskWithRequest(request) {
                    (responseData, response, error) -> Void in
                    if (error != nil) {
                        callback("", error.localizedDescription)
                    } else {
                        callback(NSString(data: responseData,
                            encoding: NSUTF8StringEncoding)! as String, nil)
                    }
            }
            
            task.resume()
    }
    
    class func JSONParseDict(jsonString:String) -> Dictionary<String, AnyObject> {
        var e: NSError?
        var data: NSData = jsonString.dataUsingEncoding(
            NSUTF8StringEncoding)!
        
//        if !NSJSONSerialization.isValidJSONObject(data) {
//            return Dictionary<String, AnyObject>()
//        }
        
        var jsonObj = NSJSONSerialization.JSONObjectWithData(
            data,
            options: NSJSONReadingOptions.MutableLeaves,
            error: &e) as! Dictionary<String, AnyObject>
        if (e != nil) {
            return Dictionary<String, AnyObject>()
        } else {
            return jsonObj
        }
    }
}
