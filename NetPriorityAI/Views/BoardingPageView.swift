//
//  BoardingPageView.swift
//  NetPriorityAI
//
//  Created by Howard Tung on 4/12/25.
//

import SwiftUI
import TipKit

class UserProfile {
    var firstNameProfile: String = ""
    var lastNameProfile: String = ""
    var occupationProfile: String = ""
    var companyProfile: String = ""
    var aboutProfile: String = ""
}


struct BoardingPageView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var userProfile = UserProfile()
    @State private var showAlert = false
    private let tipService = TipService.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TipView(tipService.createProfileTip)
                
                // Form Fields
                VStack {
                    CreateProfileTextField(labelText: "First Name", text: $userProfile.firstNameProfile)
                    
                    CreateProfileTextField(labelText: "Last Name", text: $userProfile.lastNameProfile)
                    
                    CreateProfileTextField(labelText: "Current Occupation", text: $userProfile.occupationProfile)
                    
                    CreateProfileTextField(labelText: "Current Company / School", text: $userProfile.companyProfile)
                    
                    CreateProfileTextField(labelText: "About", text: $userProfile.aboutProfile, height: 120)
                    
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.system(size: 17))
                            .frame(minWidth: 70)
                            .foregroundColor(.textPrimary)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.appSecondary, lineWidth: 1))
                    }.padding(.top, 20)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Create")
                            .font(.system(size: 17))
                            .frame(minWidth: 70)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }.padding(.top, 20)
                }
            }.padding(.top, 20)
            
                .alert("Profile Created", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Your profile has been created successfully.")
                }
        }
    }
    
    private func isFormValid() -> Bool {
        return !userProfile.firstNameProfile.isEmpty && !userProfile.lastNameProfile.isEmpty
    }
    
    private func saveUserProfile() {
        // 這裡會實現將用戶資料保存到 CoreData 或其他存儲的邏輯
        print("Saving user profile: \(userProfile)")
        
        // 顯示成功提示
        showAlert = true
        
        // 在實際應用中，這裡會使用 CoreData 存儲用戶資料
        // persistenceController.saveUserProfile(userProfile)
    }
}


struct CreateProfileTextField: View {
    var labelText: String
    @Binding var text: String
    var height: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(labelText)
                .font(.system(size: 17))
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            if let height = height {
                TextEditor(text: $text)
                    .frame(height: height)
                    .font(.system(size: 17))
                    .padding(4)
                    .background(.backgroundPrimary)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.appSecondary, lineWidth: 1)
                    ).shadow(
                        color: Color.black.opacity(0.12),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            } else {
                TextField("", text: $text)
                    
                    .padding(5)
                    .padding(.horizontal, 10)
                    .background(.backgroundPrimary)
                
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.appSecondary, lineWidth: 1)
                    )
                    .shadow(
                        color: Color.black.opacity(0.12),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            }
        }
        .padding(.bottom, 20)
    }
}


#Preview {
    BoardingPageView()
}

#Preview("Text Field") {
    VStack {
        CreateProfileTextField(
            labelText: "First Name",
            text: .constant("")
            
        ).padding()
        
        CreateProfileTextField(
            labelText: "About",
            text: .constant(""),
            height: 120
        )
        .padding()
    }
}
