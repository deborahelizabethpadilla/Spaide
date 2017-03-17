//
//  ChatViewController.swift
//  Spaide
//
//  Created by Deborah on 3/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit
import Firebase
import SDWebImage

class ChatViewController: JSQMessagesViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MessageReceivedDelegate {
    
    //Variables
    
    private var messages = [JSQMessage]()
    
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Picker Delegate & Message Functions
        
        picker.delegate = self
        MessagesHandler.Instance.delegate = self
        
        self.senderId = AuthProvider.Instance.userID()
        self.senderDisplayName = AuthProvider.Instance.userName
        
        MessagesHandler.Instance.observeMessages()
        MessagesHandler.Instance.observeMediaMessages()
        
        //Set Background Of Controller
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundimage3.png")!)
        
    }
    
    //Collection View Functions
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        //Variables
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.item]
        
        if message.senderId == self.senderId {
            
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
            
        } else {
            
            return bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.orange)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "ProfileImg"), diameter: 30)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let msg = messages[indexPath.item]
        
        if msg.isMediaMessage {
            
            if let mediaItem = msg.media as? JSQVideoMediaItem {
                
                let player = AVPlayer(url: mediaItem.fileURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    //Sending Button Functions
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        MessagesHandler.Instance.sendMessage(senderID: senderId, senderName: senderDisplayName, text: text)
        
        //Remove Text From Text Field
        
        finishSendingMessage()
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        let alert = UIAlertController(title: "Media Messages", message: "Please Select A Media", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let photos = UIAlertAction(title: "Photos", style: .default,    handler: { (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeImage)
        })
        
        let videos = UIAlertAction(title: "Videos", style: .default,    handler: { (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeMovie)
        })
        
        alert.addAction(photos)
        alert.addAction(videos)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    //Picker View Functions
    
    private func chooseMedia(type: CFString) {
        
        picker.mediaTypes = [type as String]
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let data = UIImageJPEGRepresentation(pic, 0.01)
            
            MessagesHandler.Instance.sendMedia(image: data, video: nil, senderID: senderId, senderName: senderDisplayName)
            
        } else if let vidURL = info[UIImagePickerControllerMediaURL] as? URL {
            
            MessagesHandler.Instance.sendMedia(image: nil, video: vidURL, senderID: senderId, senderName: senderDisplayName)
            
        }
        
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    //Delegation Functions
    
    func messageReceived(senderID: String, senderName: String, text: String) {
        
        messages.append(JSQMessage(senderId: senderID, displayName: senderName, text: text))
        collectionView.reloadData()
    }
    
    func mediaReceived(senderID: String, senderName: String, url: String) {
        
        if let mediaURL = URL(string: url) {
            
            do {
                
                let data = try Data(contentsOf: mediaURL)
                
                if let _ = UIImage(data: data) {
                    
                    let _ = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil, completed: { (image, data, error, finished) in
                        
                        DispatchQueue.main.async {
                            
                            let photo = JSQPhotoMediaItem(image: image)
                            
                            if senderID == self.senderId {
                                
                                photo?.appliesMediaViewMaskAsOutgoing = true
                                
                            } else {
                                
                                photo?.appliesMediaViewMaskAsOutgoing = false
                            }
                            
                            self.messages.append(JSQMessage(senderId: senderID, displayName: senderName, media: photo))
                            self.collectionView.reloadData()
                            
                        }
                        
                    })
                    
                } else {
                    
                    let video = JSQVideoMediaItem(fileURL: mediaURL, isReadyToPlay: true)
                    
                    if senderID == self.senderId {
                        
                        video?.appliesMediaViewMaskAsOutgoing = true
                        
                    } else {
                        
                        video?.appliesMediaViewMaskAsOutgoing = false
                    }
                    
                    messages.append(JSQMessage(senderId: senderID, displayName: senderName, media: video));
                    self.collectionView.reloadData()
                    
                }
                
            } catch {
                
                //Potential Errors
            }
            
        }
        
    }
    
    //Back Button Action 
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
