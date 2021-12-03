//
//  SignInView.swift
//  AUSTTravels
//
//  Created by Shahriar Nasim Nafi on 30/11/21.
//  Copyright © 2021 Shahriar Nasim Nafi. All rights reserved.
//

import SwiftUI
import Defaults

struct SignInView: View {
    
    @EnvironmentObject var austTravel: AUSTTravel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var emailIsEditing: Bool = false
    @State private var passwordIsEditing: Bool = false
    @State private var isPasswordHIdden: Bool = true
    
    var body: some View {
        ZStack  {
            LinearGradient(colors: [.green, .green, .green, .greenLight], startPoint: .topLeading, endPoint: .bottomTrailing)
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Spacer()
                        Text("AUST BUS")
                            .scaledFont(font: .sairaCondensedBold, dsize: 51)
                            .foregroundColor(.white)
                        
                        HStack {
                            Icon(name: "envelope")
                                .systemImage()
                                .iconColor(.greenLight)

                            TextField("", text: $email)
                                .keyboardType(.emailAddress)
                                .placeholder(when: $email.wrappedValue.isEmpty) {
                                    Text("Enter your email")
                                }
                                .frame(height: 47.dHeight())
                                .scaledFont(font: .sairaCondensedRegular, dsize: 17)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: dWidth * 0.85)
                        .padding(10.dHeight())
                        .overlay(RoundedRectangle(cornerRadius: 7.dWidth()).stroke(emailIsEditing ? Color.black : Color.gray, lineWidth: 1.dWidth()))
                        .padding(.horizontal, 15.dHeight())
                        
                        HStack {
                            Icon(name: "lock.fill")
                                .systemImage()
                                .iconColor(.greenLight)

                            if isPasswordHIdden {
                                SecureField("", text: $password)
                                    .keyboardType(.default)
                                    .placeholder(when: $password.wrappedValue.isEmpty) {
                                        Text("Enter your password")
                                    }
                                    .frame(height: 47.dHeight())
                                    .scaledFont(font: .sairaCondensedRegular, dsize: 17)
                                    .foregroundColor(.white)
                            } else {
                                TextField("", text: $password)
                                    .keyboardType(.default)
                                    .placeholder(when: $password.wrappedValue.isEmpty) {
                                        Text("Enter your password")
                                    }
                                    .frame(height: 47.dHeight())
                                    .scaledFont(font: .sairaCondensedRegular, dsize: 17)
                                    .foregroundColor(.white)
                            }
                            
                            Button {
                                isPasswordHIdden.toggle()
                            } label: {
                                
                                Image(systemName: isPasswordHIdden ? "eye.fill" : "eye.slash.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .foregroundColor(.greenLight)
                                    .scaledToFit()
                                    .frame(height: 14.dWidth(), alignment: .center)
                            }
                            
                        }
                        .frame(width: dWidth * 0.85)
                        .padding(10.dHeight())
                        .overlay(RoundedRectangle(cornerRadius: 7.dWidth()).stroke(passwordIsEditing ? Color.black : Color.gray, lineWidth: 1.dWidth()))
                        .padding(.horizontal, 15.dHeight())
                        
                        
                        ABButton(text: "SIGN IN", textColor: .black, backgroundColor: .white, font: .sairaCondensedSemiBold) {
                            austTravel.authViewModel.signIn(email: email, password: password) { isVerified, error in
                                guard isVerified == true else {
                                    return
                                }
                                austTravel.currentAuthPage = .none
                                Defaults[.authStatePage] = .none
                            
                                austTravel.currentFirebaseUser = austTravel.authViewModel.user
                            }
                        }
                        
                        
                        Button {
                            
                            withAnimation {
                                austTravel.currentAuthPage = .forgetPassword
                            }
                        
                        } label: {
                            HStack {
                                Spacer()
                                Text("Forgot your password?")
                                    .scaledFont(font: .sairaCondensedSemiBold, dsize: 14)
                                    .foregroundColor(.white)
                                
                            }
                            .frame(width: dWidth * 0.9)
                            .padding(0)
                        }
                        
                        
                        
                        HStack {
                            Rectangle()
                                .frame(width: dWidth * 0.4, height: 2.dWidth())
                            Spacer()
                            Text("OR")
                                .scaledFont(font: .sairaCondensedSemiBold, dsize: 15)
                            Spacer()
                            Rectangle()
                                .frame(width: dWidth * 0.4, height: 2.dWidth())
                        }
                        .foregroundColor(.white)
                        .frame(width: dWidth * 0.9)
                        
                        ABButton(text: "SIGN UP WITH EMAIL", textColor: .black, backgroundColor: .yellow, font: .sairaCondensedSemiBold) {
                            
                            withAnimation {
                                austTravel.currentAuthPage = .signUp
                            }
                        }
                        
                        Spacer()
                        
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
