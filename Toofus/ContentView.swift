//
//  ContentView.swift
//  SwiftUIMenu
//
//  Created by Denis Vinogradov on 04.04.2020.
//  Copyright © 2020 Denis Vinogradov. All rights reserved.
//

import SwiftUI

struct IV : View {
	@EnvironmentObject var appSettings: AppSettings

	let index : Int
	let name : String

	var body: some View {
		return Image(name).resizable()
			.scaledToFit()
			.padding(-170)
			.aspectRatio(contentMode: .fit )
			.clipShape(Circle().inset(by: CGFloat(28)))
			.shadow(radius: 4)
			.gesture(
				TapGesture()
					.onEnded { _ in
						self.appSettings.chapter = self.index
						self.appSettings.currentMenu = 0
						print(self.appSettings.chapter)

				}
			)
	}
}


struct ChapterList : View {
	@EnvironmentObject var appSettings: AppSettings
	

//	init() {
//		// To remove only extra separators below the list:
//		UITableView.appearance().tableFooterView = UIView()
//		// To remove all separators including the actual ones:
//		UITableView.appearance().separatorStyle = .none
//	}

	var body: some View {
		return
			NavigationView {
				VStack  (alignment: .leading, spacing: 1)  {
					ScrollView {
						VStack {
							ForEach(self.appSettings.chapters.indices) { index in
								IV(index : index, name : self.appSettings.chapters[index].id)
							}
						}
					}
					MenuView()
				}.navigationBarItems(leading:
					ZStack {
						Rectangle().foregroundColor(.white)
							.frame(width: UIScreen.main.bounds.width+10, height: 120, alignment: .leading)
							.shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.08), radius: 2, x: 0, y: 4)
						HStack {
							Text("Welcome back!").font(.custom("Avenir", size: 15))
							Text("saki").font(.custom("Avenir Havy", size: 15))
							Spacer()
							ZStack {
								Circle().frame(width: 50, height: 50, alignment: .topTrailing).foregroundColor(Color(hex : 0x5443AF))
								Text("js").foregroundColor(.white).font(.custom("Avenir Havy", size: 17))
							}.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
						}
						.frame(maxWidth : .infinity, alignment: .leading)
						.padding(EdgeInsets(top: 40, leading: 35, bottom: 0, trailing: 0))
					}
				)
			}
		}
}

struct ContentView: View {

	@EnvironmentObject var appSettings: AppSettings
	let cl = ChapterList()
	let cv = ChapterView()

	var body: some View {
		HStack {
			if (appSettings.chapter == -1) {
				self.cl
			} else {
				self.cv
			}
		}
		.animation(Animation.spring(
			response: 0.8, dampingFraction: 0.5, blendDuration: 0.8
		))

	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppSettings())
    }
}

