//
//  ChatModel.swift
//  Chatting
//
//  Created by 이건준 on 2021/11/05.
//

import UIKit

class ChatModel:NSObject{
    var users = [String:Bool]() //채팅방에 참여한 사람들
    var comments = [String:Comment]() //채팅방의 대화내용
    
    class Comment{
        var uid:String?
        var message:String?
    }
}
