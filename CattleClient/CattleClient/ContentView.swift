//
//  ContentView.swift
//  CattleClient
//
//  Created by 전지민 on 2023/04/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @State var entityNumber = ""
    
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    var body: some View {
        VStack {
            HStack {
                Text("개체번호")
                TextField("개체번호", text: $entityNumber)
            }
            HStack {
                Text("사진 선택하기")
                TextField("개체번호", text: $entityNumber)
            }
            
            Button(action: {
                self.showingImagePicker.toggle()
//                mainViewController.selectPhoto()
            }, label: {
                Text("사진 선택하기")
            })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { (image) in

                    self.pickedImage = Image(uiImage: image)
                    print(image)
                }
            }
            pickedImage?.resizable()
                .frame(height:300)
        }
        .padding()
        .onAppear() {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
