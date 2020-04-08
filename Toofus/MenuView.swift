//
//  MenuView.swift
//  SwiftUIMenu
//
//  Created by Denis Vinogradov on 04.04.2020.
//  Copyright © 2020 Denis Vinogradov. All rights reserved.
//

import SwiftUI

struct MenuView: View {
	
	var body: some View {
		
		return ZStack {
			VStack {
				Rectangle()
					.cornerRadius(30)
					.foregroundColor(Color(.white))
					.frame(maxHeight : 60)
					.padding(16)
					.shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.15), radius: 6, x: 0, y: 0)
			}
			VStack {
					HStack {
						MainButton(name: "HOME", index: 1, image : "square.grid.2x2.fill")
						MainButton(name: "LIB", index: 2, image : "folder.fill")
						MainButton(name: "OPT", index: 3, image : "gear")
						MainButton(name: "INFO", index: 4, image : "person.fill")
					}
					.padding(.horizontal, 25)
					.frame(maxWidth: .infinity)
			}
		}
	}
}

struct MainButton : View {
	
	@EnvironmentObject var appSettings: AppSettings
	
	let name : String
	let index : Int
	let image : String
	
	var body : some View {
		
		let isCurrent = index == self.appSettings.currentMenu
		
		return ZStack {
			if isCurrent {
				Rectangle()
					.cornerRadius(30)
					.foregroundColor(Color(hex: 0x5443AF))
					.frame(height:40)
					.padding(.bottom, 1)
			}
			HStack{
				Image(systemName: image)
					.resizable()
					.frame(width: 24, height: 24, alignment: .center)
					.foregroundColor((isCurrent ? .white : Color(hex: 0xB1B1B1)))
					.gesture(
						TapGesture()
							.onEnded { _ in
								print(self.appSettings.chapter)
								self.appSettings.currentMenu = self.index
//								if self.index == 1 {
//									self.appSettings.chapter = nil
//								}
//								if self.index == 3 {
//									self.appSettings.settingMenu.toggle()
//								}
						}
				)
				if isCurrent {
					Button(action: {
						self.appSettings.currentMenu = self.index
					}) {
						Text(name).font(.custom("Avenir Heavy", size: 13))
							.frame(width: 50)
							.foregroundColor(.white)
					}
					
				}
				
			}
			.padding(.horizontal, 20)
		}
		.animation(Animation.easeInOut(duration: 0.5))
	}
	
}

struct MenuView_Previews: PreviewProvider {
	static var previews: some View {
		MenuView().environmentObject(AppSettings())
	}
}
