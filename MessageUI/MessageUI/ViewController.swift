//
//  ViewController.swift
//  MessageUI
//
//  Created by User on 2021/08/11.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Message:MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender:SenderType {
    var photoString: String
    var senderId: String
    var displayName: String
}

class ViewController: MessagesViewController {
    private var messages = [Message]()
    private let mySender = Sender(photoString: "profile1", senderId: "1", displayName: "Me")
    
    private let yourSender = Sender(photoString: "profile2", senderId: "2", displayName: "Olivia Brown")
    private var dateInterval:TimeInterval = -20000
    private var messageId = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message(sender: mySender, messageId: "1", sentDate: Date().addingTimeInterval(-50000), kind: .text("Hi! My name is Minsu Kim, how can I help you today?")))
        messages.append(Message(sender: yourSender, messageId: "2", sentDate: Date().addingTimeInterval(-40000), kind: .text("Hi! I'm havind trouble logging in.")))
        messages.append(Message(sender: mySender, messageId: "3", sentDate: Date().addingTimeInterval(-30000), kind: .text("Thank you for you email. We'll be in touch as soon as possible.")))
        messages.append(Message(sender: mySender, messageId: "\(messageId)", sentDate: Date().addingTimeInterval(dateInterval), kind: .text("Okay. I can help you with that.")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.delegate = self
        messageInputBar.delegate = self
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        
        }
    }


}

extension ViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    
    func currentSender() -> SenderType {
        return mySender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.senderId == mySender.senderId {
            avatarView.set(avatar: Avatar(image: .none, initials: ""))
            avatarView.isHidden = true
        } else {
            avatarView.set(avatar: Avatar(image: UIImage(named: "profile2"), initials: "Olivia Brown"))
            avatarView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
    }

    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if message.sender.senderId == mySender.senderId {
            return nil
        } else {
            return NSAttributedString(
                  string: message.sender.displayName,
                  attributes: [.font: UIFont.systemFont(ofSize: 12)])
        }
    }
    
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if message.sender.senderId == mySender.senderId {
            return 0
        } else {
            return 20
        }
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(
            string: "\(message.sentDate)",
            attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func avatarPosition(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> AvatarPosition {
        if message.sender.senderId == mySender.senderId {
            return AvatarPosition(vertical: .cellTop)
        } else {
            return AvatarPosition(vertical: .messageCenter)
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .topRight : .topLeft
                return .bubbleTail(corner, .curved)
    }
    
}

extension ViewController:InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        
        inputBar.inputTextView.text = ""
        let newMessageId = "\(messageId)"
        dateInterval -= 1000
        messages.append(Message(sender: mySender, messageId: "\(newMessageId)", sentDate: Date().addingTimeInterval(dateInterval), kind: .text(text)))
        
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
        }
        
    }
}
