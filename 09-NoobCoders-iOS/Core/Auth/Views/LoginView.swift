//
//  LoginView.swift
//  09-NoobCoders-iOS
//
//  Created by Prathamesh Araikar on 25/09/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var authVm: AuthViewModel = AuthViewModel()
    @AppStorage("currentUserSignIn") var currentUserSignIn: Bool = false
    @AppStorage("userOnLoginScreen") var userOnLoginScreen: Bool = true
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var showEmailAlert: Bool = false
    @State var showPasswordAlert: Bool = false
    @State var emailAlertTitle: String = ""
    @State var passwordAlertTitle: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("Login")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                    .padding(.bottom, 30)
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.theme.secondaryBackground)
                    .frame(width: UIScreen.main.bounds.width/1.15, height: UIScreen.main.bounds.height/1.5)
                    .shadow(radius: 10)
                    .overlay(
                        VStack(alignment: .leading) {
                            HStack(spacing: 20.0) {
                                Image(systemName: "envelope")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.theme.accent)
                                    .padding(.leading, 25)
                                
                                Text("Email")
                                    .foregroundColor(Color.theme.accent)
                                    .font(.title3)
                                    .fontWeight(.light)
                            }
                            .padding(.top, 30)
                            
                            
                            TextField("", text: $email)
                                .placeholder(when: email.isEmpty, placeholder: {
                                    Text("mikasa@gmail")
                                        .foregroundColor(Color.theme.secondaryText)
                                })
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .padding()
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                            
                            Divider()
                            
                            HStack(spacing: 20.0) {
                                Image(systemName: "lock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.theme.accent)
                                    .padding(.leading, 25)
                                
                                Text("Password")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.light)
                            }
                            .padding(.top)
                            
                            HStack {
                                if showPassword {
                                    TextField("", text: $password)
                                        .placeholder(when: password.isEmpty, placeholder: {
                                            Text("123456")
                                                .foregroundColor(Color.theme.secondaryText)
                                        })
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal)
                                        .foregroundColor(Color.theme.accent)
                                        .background(Color.theme.secondaryText.opacity(0.1))
                                        .cornerRadius(20)
                                        .padding()
                                        .disableAutocorrection(true)
                                        .textInputAutocapitalization(.never)
                                    
                                } else {
                                    SecureField("", text: $password)
                                        .placeholder(when: password.isEmpty, placeholder: {
                                            Text("123456")
                                                .foregroundColor(Color.theme.secondaryText)
                                        })
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal)
                                        .foregroundColor(Color.theme.accent)
                                        .background(Color.theme.secondaryText.opacity(0.1))
                                        .cornerRadius(20)
                                        .padding()
                                        .disableAutocorrection(true)
                                        .textInputAutocapitalization(.never)
                                }
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor( showPassword ? Color.theme.accent : .green)
                                        .frame(width: 30, height: 30)
                                        .padding(.trailing)
                                }
                            }
                            
                            Button {
                                emailAlertTitle = handleEmailAlert()
                                passwordAlertTitle = handlePasswordAlert()
                                if emailAlertTitle == "" && passwordAlertTitle == "" {
                                    handleLoginButtonPressed()
                                }
                            } label: {
                                Text("Login")
                                    .foregroundColor(Color.theme.accent)
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.theme.darkOrangeColor)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                    .padding(.horizontal)
                            }
                            .alert(emailAlertTitle, isPresented: $showEmailAlert) {}
                            .alert(passwordAlertTitle, isPresented: $showPasswordAlert) {}
                            .alert(authVm.userDoesNotExistTitle,
                                   isPresented: $authVm.showUserDoesNotExistAlert) {}
                            
                            Divider()
                            
                            VStack(alignment: .center) {
                                Text("OR")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button {
                                handleSignUpButtonPressed()
                            } label: {
                                Text("Register")
                                    .foregroundColor(Color.theme.accent)
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.theme.lightOrangeColor)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                    .padding(.horizontal)
                            }
                            Spacer()
                        }
                        
                    )
            }
        }
    }
}

extension LoginView {
    
    func handleEmailAlert() -> String {
        
        if email.isEmpty {
            showEmailAlert.toggle()
            return "Please enter your email id 😭"
        }
        
        if email.count < 10 {
            showEmailAlert.toggle()
            return "Please enter complete email id 🥺🥺🥺"
        }
        
        if  !email.contains("@") {
            showEmailAlert.toggle()
            return "Invalid email 😢😢😢"
        }
        
        return ""
    }
    
    func handlePasswordAlert() -> String {
        if password.isEmpty {
            showPasswordAlert.toggle()
            return "Please enter a password 😱"
        }
        
        if password.count < 6 {
            showPasswordAlert.toggle()
            return "Password should be atleast 6 characters long 🧐🧐🧐"
        }
        
        return ""
    }
    
    func handleLoginButtonPressed() {
        authVm.login(email: email, password: password)
    }
    
    func handleSignUpButtonPressed() {
        withAnimation(.spring()) {
            userOnLoginScreen = false
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
