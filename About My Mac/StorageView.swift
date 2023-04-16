//
//  StorageView.swift
//  About My Mac
//
//  Created by Ben Sova on 8/19/22.
//

import VeliaUI

struct StorageView : View {
    
    var body: some View {
        
        ZStack {
            Rectangle().foregroundColor(.white.opacity(0.00000001))
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VIHeader(p: "Storage", s: "About My Mac v\(AppInfo.version)")
                            .alignment(.leading)
                        Spacer()
                    }.padding(.bottom, 5)
                    
                    HStack(alignment: .top) {
                        Image("InternalDisk")
                            .interpolation(.high)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .padding(.bottom, -3.5)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Macintosh HD")
                                .font(.headline)
                            Text("82.53 GB available of 256 GB")
                                .padding(.bottom, 5)
                            ZStack(alignment: .leading) {
                                ProgressBar(value: .constant(0.677617), length: 450)
                                Text("  ")
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .padding(.horizontal, 5)
                            }.fixedSize()
                                .padding(.bottom, 15)
                            Text("Other Drive")
                                .font(.headline)
                            Text("8.53 GB available of 234 GB")
                                .padding(.bottom, 5)
                            ZStack(alignment: .leading) {
                                ProgressBar(value: .constant(0.1872), length: 450)
                                Text("  ")
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .padding(.horizontal, 5)
                            }.fixedSize()
                        }.padding(.bottom, 3.5)
                    }.fixedSize()
                }.padding(30)
                    .padding(.top, 7.5)
            }
        }.ignoresSafeArea(.all)
        
    }
    
}


struct ProgressBar: View {
    @Binding var value: CGFloat
    var length: CGFloat = 285
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle().frame(minWidth: length)
                .opacity(0.3)
                .foregroundColor(Color("Accent").opacity(0.9))
            
            Rectangle().frame(width: min(value*length, length))
                .foregroundColor(Color("Accent"))
                .animation(.linear)
                .cornerRadius(7)
        }.cornerRadius(7)
    }
}
