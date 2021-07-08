//
//  EmailService.swift
//  MacBryte
//
//  Created by Dhruv Rawat on 2021-06-10.
//

import Cocoa
import Network

/*
 Handles email sending
 */
class EmailService : NSObject {
    static private let service : NSSharingService = NSSharingService.init(named: NSSharingService.Name.composeEmail)!
    static private let recipient : [String] = [Constants.macbryteInfoEmail]
    static private let subject : String = Constants.defaultHelpEmailSubject
    static private let placeholderText : [String] = [Constants.defaultEmailContent]
    
    static func sendEmail() {
        service.recipients = recipient
        service.subject = subject
        service.perform(withItems: placeholderText)
    }
    
    static func sendEmail(to emails: [String]) {
        service.recipients = emails
        service.subject = subject
        service.perform(withItems: placeholderText)
    }
}
