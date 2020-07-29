//
//  ConversationController+Test.swift
//  TIMLite
//
//  Created by xcoderliu on 11/28/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit


extension ConversationController {
    //MARK: - APIV2 test should not run in main Thread
    func testAPIV2() {
        /*
        assert(!Thread.current.isMainThread)
        
        imMark("--开始检测API2.0--")
        
        imMark("--当前登录用户--")
        // get user
        imPass("get login user :\(V2TIMManager.sharedInstance()?.getLoginUser() ?? "nil")")
        sleep(2)
        
        imMark("--获取当前日志路径--")
        // get log path
        imPass("get log Path :\(V2TIMManager.sharedInstance()?.getLogPath() ?? "nil")")
        sleep(2)
        
        let userTest0 = "xcoderlzm"
        let userTest1 = "xcodertest"
        
        //getfriendlist
        imMark("--获取好友列表--")
        V2TIMManager.sharedInstance()?.getFriendList({ (profiles) in
            imPass("getFriendList success")
            TinyConsole.addLine()
            for profile in profiles ?? [] {
                imPrint(profile.userID)
            }
            TinyConsole.addLine()
        }, fail: {(code, errorDes) in
            imError("getFriendList failed, code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(2)
        
        //check friend
        imMark("--检查好友关系--")
        imMark("checkFriend 先来检查个熟人")
        V2TIMManager.sharedInstance()?.checkFriend(userTest1, succ: { (result) in
            imPass("checkFriend success，user: \(userTest1)")
        }, fail: {(code, errorDes) in
            imError("checkFriend failed, user: \(userTest1), code: \(code), error: \(errorDes ?? "nil")")
        })
         sleep(2)
        
        imMark("--检查好友关系--")
        imMark("checkFriend 再来个陌生人")
        let randomUser0 = String.randomStr(len: 6)
        V2TIMManager.sharedInstance()?.checkFriend(randomUser0, succ: { (result) in
            imPass("checkFriend success，user: \(randomUser0)")
        }, fail: {(code, errorDes) in
            imError("checkFriend failed, user: \(randomUser0), code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(2)
        
        imMark("--获取好友申请列表--")
        V2TIMManager.sharedInstance()?.getFriendApplicationList({ (resp) in
            imPass("getFriendApplicationList success, unread: \(resp?.unreadCount ?? 0)")
        }, fail: {(code, errorDes) in
            imError("getFriendApplicationList failed, user: \(randomUser0), code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(2)
        
        imMark("--设置好友申请列表已读--")
        V2TIMManager.sharedInstance()?.setFriendApplicationRead(UInt64(Date.init().timeIntervalSince1970), succ: {
            imPass("setFriendApplicationRead success")
        }, fail: {(code, errorDes) in
            imError("setFriendApplicationRead failed, code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(2)
        
        
        var groupConvs: [V2TIMConversation] = []
        
        // get conversation list
        imMark("--获取会话列表--")
        
        let convs = V2TIMManager.sharedInstance()?.getConversationList()
        var sendDesConv: V2TIMConversation?
        if (convs?.count ?? 0) > 0 {
            imPass("getConversationList success")
        }
        
        TinyConsole.addLine()
        for conv in convs ?? [] {
            conv.getShowName { (name) in
                if let na = name {
                    imPrint("get conversation:\(na) from ConversationList")
                }
            }
            
            if conv.type == .GROUP {
                groupConvs.append(conv)
            }
            
            if sendDesConv == nil &&
                conv.conversationID == userTest0 {
                sendDesConv = conv
            }
        }
        TinyConsole.addLine()
        sleep(4)
        
        imMark("--群成员检查--")
        //group
        for groupConv in groupConvs {
            V2TIMManager.sharedInstance()?.getGroupMemberList(groupConv.conversationID, succ: { (members) in
                groupConv.getShowName { (name) in
                    if let na = name {
                        TinyConsole.addLine()
                        imPass("\(na) getGroupMemberList success")
                        for member in members ?? [] {
                            if let id = member.memberID {
                                imPrint("\(na) have member: \(id)")
                            }
                        }
                        TinyConsole.addLine()
                    }
                }
                
            }, fail: { (code, errorDes) in
                imError("getGroupMemberList failed, code: \(code), error: \(errorDes ?? "nil")")
            })
        }
        sleep(6)
        
        imMark("--群申请--")
        
        // group application list
        V2TIMManager.sharedInstance()?.getGroupApplicationList({ (resp) in
            imPass("getGroupApplicationList success, unread \(resp?.unreadCount ?? 0)")
        }, fail: { (code, errorDes) in
            imError("getGroupApplicationList failed, code: \(code), error: \(errorDes ?? "nil")")
        })
        
        // setGroupApplicationRead
        V2TIMManager.sharedInstance()?.setGroupApplicationRead(UInt64(Date.init().timeIntervalSince1970), succ: {
            imPass("setGroupApplicationRead success")
        }, fail: { (code, errorDes) in
            imError("setGroupApplicationRead failed, code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(3)
    
        imMark("--用户信息本地--")
        //user profile
        
        //queryUserProfile
        if let user = V2TIMManager.sharedInstance()?.queryUserProfile(userTest1) {
            imPass("queryUserProfile success, user: \(userTest1) FaceUrl: \(user.faceURL ?? "nil")")
        } else {
            imError("queryUserProfile failed, user: \(userTest1)")
        }
        sleep(2)
        imMark("--用户信息联网--")
        //getUserProfile
        let randomUser = String.randomStr(len: 6)
        V2TIMManager.sharedInstance()?.getUserProfile([randomUser], succ: { (profiles) in
            if (profiles?.first?.userID.count ?? 0) > 0 {
                #warning("tell me how to do with error profile")
                imPass("getUserProfile success, user: \(randomUser)), FaceUrl: \((profiles?.first)?.faceURL ?? "nil") 中奖了 随机都能搜到 ！！！")
            } else {
                imError("getUserProfile failed, user: \(randomUser)")
            }
        }, fail: { (code, errorDes) in
            imError("getUserProfile failed, user: \(randomUser), code: \(code), error: \(errorDes ?? "nil")")
        })
        
        sleep(3)
        imMark("--用户信息修改--")
        imMark("❌故意设置错误案例,不能设置非本人的 customInfo")
        V2TIMManager.sharedInstance()?.getUserProfile(["xcodetest"], succ: { (profiles) in
            imPass("getUserProfile success, user: xcodetest, FaceUrl: \((profiles?.first)?.faceURL ?? "nil")")
            // modifyUserProfile
            profiles?.first?.customInfo["test"] = Data(userTest1.utf8)
            V2TIMManager.sharedInstance()?.modifyUserProfile(profiles?.first, succ: {
                imPass("modifyUserProfile success, user: xcodetest")
            }, fail: { (code, errorDes) in
                imError("modifyUserProfile failed, user: xcodetest, code: \(code), error: \(errorDes ?? "nil")")
            })
        }, fail: { (code, errorDes) in
            imError("getUserProfile failed, user: xcodetest, code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(3)
        if let localUser = V2TIMManager.sharedInstance()?.getLoginUser() {
            imMark("✅正确案例")
            V2TIMManager.sharedInstance()?.getUserProfile([localUser], succ: { (profiles) in
                imPass("getUserProfile success, user: xcoderliu, FaceUrl: \((profiles?.first)?.faceURL ?? "nil")")
                // modifyUserProfile
                profiles?.first?.customInfo["Tag_Profile_Custom_Str"] = Data(String.randomStr(len: 8).utf8)
                V2TIMManager.sharedInstance()?.modifyUserProfile(profiles?.first, succ: {
                    imPass("modifyUserProfile success, user: xcoderliu")
                }, fail: { (code, errorDes) in
                    imError("modifyUserProfile failed, user: xcoderliu, code: \(code), error: \(errorDes ?? "nil")")
                })
            }, fail: { (code, errorDes) in
                imError("getUserProfile failed, user: xcoderliu, code: \(code), error: \(errorDes ?? "nil")")
            })
            sleep(3)
        }
        
        imMark("卧槽，我要删除我自己的好友了，后面加回来千万别出错")
        
        V2TIMManager.sharedInstance()?.delete(fromFriendList: [userTest1], delete: .FRIEND_TYPE_BOTH, succ: { (result) in
            imPass("delete friend success, user: \(userTest1)")
            let request = V2TIMFriendAddApplication.init()
            request.userID = "\(userTest1)"
            request.addType = .FRIEND_TYPE_BOTH
            V2TIMManager.sharedInstance()?.addFriend(request, succ: { (result) in
                imMark("卧槽，加回来了？")
                imPass("add friend success, user: \(userTest1)")
            }, fail: { (code, errorDes) in
                imError("add friend failed, user: \(userTest1), code: \(code), error: \(errorDes ?? "nil")")
            })
        }, fail: { (code, errorDes) in
            imError("delete friend failed, user: \(userTest1), code: \(code), error: \(errorDes ?? "nil")")
        })
        sleep(2)
        
        imMark("--c2c消息--")
        // get destionation to send message and create temp group
        if let des = sendDesConv {
            // message
            let textMessage = V2TIMManager.sharedInstance()?.createTextMessage("hello this is a test textmessage from xcoderliu")
            // send message
            V2TIMManager.sharedInstance()?.sendMessage(des, message: textMessage, type: .MSG_SEND_TYPE_NORMAL, succ: {
                imPass("send message success")
            }, fail: { (code, errorDes) in
                imError("send message failed, code: \(code), error: \(errorDes ?? "nil")")
            })
            
            sleep(3)
            
            imMark("--撤回消息--")
            // revoke message
            V2TIMManager.sharedInstance()?.revokeMessage(des, message: textMessage, succ: {
                imPass("revoke message success")
            }, fail: { (code, errorDes) in
                imError("revoke message failed, code: \(code), error: \(errorDes ?? "nil")")
            })
            
            sleep(2)
            
            imMark("--设置消息已读--")
            // read message
            V2TIMManager.sharedInstance()?.setMessagesRead(des, succ: {
                imPass("\(des.conversationID ?? "") setMessagesRead success")
            }, fail: { (code, errorDes) in
                imError("\(des.conversationID ?? "") setMessagesRead failed, code: \(code), error: \(errorDes ?? "nil")")
            })
            sleep(2)
            
            // group
            
            let groupProfile = V2TIMGroupProfile.init()
            groupProfile.groupName = "testAPIV2\(String.randomStr(len: 8))"
            groupProfile.groupType = .GROUP_TYPE_PUBLIC
            let memberSelf = V2TIMCreateGroupMemberInfo.init()
            memberSelf.member = (V2TIMManager.sharedInstance()?.getLoginUser() ?? "xcoderliu")
            memberSelf.role = .GROUP_MEMBER_ROLE_SUPER
            let memberDes = V2TIMCreateGroupMemberInfo.init()
            memberDes.member = des.conversationID
            memberDes.role = .GROUP_MEMBER_ROLE_ADMIN
            groupProfile.memberList = [memberSelf,memberDes]
            
            imMark("--通过目标用户创建群 并验证相关操作--")
            // create group
            V2TIMManager.sharedInstance()?.createGroup(groupProfile, succ: { (groupID) in
                imPass("createGroup success")
                DispatchQueue.global(qos: .userInteractive).async {
                    let groupConv = V2TIMManager.sharedInstance()?.getConversation(.GROUP, receiver: groupID)
                    imMark("--群里发送一条消息--")
                    let createMessage = V2TIMManager.sharedInstance()?.createTextMessage("hello this is a test create group message from xcoderliu")
                    V2TIMManager.sharedInstance()?.sendMessage(groupConv, message: createMessage, type: .MSG_SEND_TYPE_NORMAL, succ: {
                        imPass("send create group message success")
                    }, fail: { (code, errorDes) in
                        imError("send create group message failed, code: \(code), error: \(errorDes ?? "nil")")
                    })
                    sleep(2)
                    
                    //                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    //                    // modifyGroupOwner
                    //                    V2TIMManager.sharedInstance()?.modifyGroupOwner(groupID, user: des.conversationID, succ: {
                    //                        debugPrint(" modifyGroupOwner success")
                    //                    }, fail: { (code, errorDes) in
                    //                        debugPrint(" modifyGroupOwner failed, code: \(code), error: \(errorDes ?? "nil")")
                    //                    })
                    //                }
                    
                    imMark("--修改群成员信息--")
                    //modify GroupMemberProfile
                    V2TIMManager.sharedInstance()?.getGroupMemberProfile(groupID, member: des.conversationID, succ: { (profile) in
                        if let role = profile?.role {
                            imPass("\(groupID ?? "") getGroupMemberProfile success, role: \(role)")
                            profile?.nameCard = "刘智民"
                            #warning("memberID nil should be fixed")
                            profile?.memberID = des.conversationID
                            V2TIMManager.sharedInstance()?.modifyGroupMemberProfile(groupID, profile: profile, succ: {
                                imPass("modifyGroupMemberProfile success")
                            }, fail: { (code, errorDes) in
                                imError("modifyGroupMemberProfile failed, code: \(code), error: \(errorDes ?? "nil")")
                            })
                        }
                    }, fail: { (code, errorDes) in
                        imError("getGroupMemberProfile failed, code: \(code), error: \(errorDes ?? "nil")")
                    })
                    sleep(3)
                    
                    sleep(4)
                    imMark("--删除群--")
                    // delete group
                    V2TIMManager.sharedInstance()?.deleteGroup(groupID, succ: {
                        imPass("deleteGroup success")
                    }, fail: { (code, errorDes) in
                        // this will failed if modifyGroupOwner is called
                        imError("deleteGroup failed, code: \(code), error: \(errorDes ?? "nil")")
                    })
                }
            }, fail: { (code, errorDes) in
                imError("createGroup failed, code: \(code), error: \(errorDes ?? "nil")")
            })
        }*/
    }
}
