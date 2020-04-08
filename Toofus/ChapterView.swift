//
//  ChapterView.swift
//  SwiftUIMenu
//
//  Created by Denis Vinogradov on 05.04.2020.
//  Copyright © 2020 Denis Vinogradov. All rights reserved.
//

import SwiftUI


struct ChapterView: View {
	@EnvironmentObject var appSettings: AppSettings
	
	var body: some View {

		return VStack(alignment: .leading, spacing: 1) {
			
			ZStack(alignment: .bottomTrailing ) {
				Color(.black).opacity(1 - self.appSettings.back).edgesIgnoringSafeArea(.all)
				ScrollView {
				VStack {
					if self.appSettings.chapter != nil &&  self.appSettings.chapter != -1 {
						Image(self.appSettings.chapters[self.appSettings.chapter!].id)
							.resizable()
							.scaledToFit()
							.scaleEffect(1.78)
							.padding(EdgeInsets(top: 55, leading: 0, bottom: 0, trailing: 0))
						Text("Chapter \(self.appSettings.chapter!+1)")
							.font(.custom(self.appSettings.font, size: 32))
							.foregroundColor(Color(hex: self.appSettings.colors[self.appSettings.colorIndex]))
							.padding(.top, 50)
						Text(self.appSettings.chapters[self.appSettings.chapter!].text)
							.font(.custom(self.appSettings.font, size: 19))
							.foregroundColor(Color(hex: self.appSettings.colors[self.appSettings.colorIndex]))
							.padding(EdgeInsets(top: 30, leading: 20, bottom: 5, trailing: 25))
						}
					}
					ScrollView (.horizontal, showsIndicators: false){
						HStack {
							ForEach(self.appSettings.chapters.indices) { index in
								ChapterSwitcher(image : self.appSettings.chapters[index].id, chapter: index)
							}
						}.frame(height:200)
					}
					.padding(.bottom, 30)
					.animation(nil)
				}
				.padding(.trailing, -8)
				.overlay(SettingsView(slide: CGFloat(0.5)),alignment: .bottom)
				.gesture(
					TapGesture()
					.onEnded { _ in
						self.appSettings.settingMenu = false
					}
				)
					//.animation(.easeIn, value: 12)
				.animation(nil)
				
				// Options menu button
				if !self.appSettings.settingMenu {
					ZStack {
						Circle().frame(width : 50).foregroundColor(Color(hex: 0x5443AF))
						Image(systemName: "slider.horizontal.3").foregroundColor(.white)
					}.frame(width:50,height:50).padding()
						
					.gesture(
							TapGesture()
								.onEnded { _ in
									self.appSettings.settingMenu.toggle()
							}
					)
				}
			
			}

			
		}.statusBar(hidden: true)
		.edgesIgnoringSafeArea(.top)
    }
}

struct ChapterSwitcher : View {
	@EnvironmentObject var appSettings: AppSettings
	
	@State var image : String
	@State var chapter : Int
	
	var body : some View {
		Image(image)
			.resizable()
			.scaleEffect(2)
			.scaledToFit()
			.padding(.trailing, 120)
		.gesture(
				TapGesture()
					.onEnded { _ in
						self.appSettings.chapter = nil
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.008) {
							self.appSettings.chapter = self.chapter
						}
				}
		)
	}
}


struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
		ChapterView().environmentObject(AppSettings())
    }
}
