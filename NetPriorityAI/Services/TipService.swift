//
//  TipService.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 4/12/25.
//

import SwiftUI
import TipKit

class TipService {
    static let shared = TipService()
    
    private init() {
        // 配置TipKit
        Task {
            // Configure and load your tips at app launch.
            do {
                resetAllTips()
                try Tips.configure()
            }
            catch {
                // Handle TipKit errors
                print("Error initializing TipKit \(error.localizedDescription)")
            }
        }
    }
    
    //    let newUserTip = NewUserTip()
    //    let scanCardTip = ScanBusinessCardTip()
    //    let priorityScoreTip = PriorityScoreTip()
    let createProfileTip = CreateProfileTip()
    
    // 重置所有提示（例如在用戶登出時）
    func resetAllTips() {
        Task {
            do {
                try Tips.resetDatastore()
            }
            catch {
                print("Error reset datastore \(error.localizedDescription)")
            }
        }
    }
}

struct CreateProfileTip: Tip {
    var title: Text {
        Text("Tip")
    }
    var message: Text? {
        Text("Please share your professional background so we can provide more personalized responses to your needs. This helps us tailor our assistance to your specific industry and expertise.")
    }
}


//// 定義各種Tip
//struct NewUserTip: Tip {
//    var title: Text {
//        Text("歡迎使用NetPriorityAI")
//    }
//
//    var message: Text? {
//        Text("開始添加您的商業聯繫人以獲取優先級建議")
//    }
//
//    var image: Image? {
//        Image(systemName: "person.badge.plus")
//    }
//}
//
//struct ScanBusinessCardTip: Tip {
//    // 實現細節...
//}
//
//struct PriorityScoreTip: Tip {
//    // 實現細節...
//}
