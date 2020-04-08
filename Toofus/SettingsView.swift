//
//  SettingsView.swift
//  SwiftUIMenu
//
//  Created by Denis Vinogradov on 07.04.2020.
//  Copyright © 2020 Denis Vinogradov. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var appSettings: AppSettings
	@State var slide : CGFloat
	
	let fonts = ["Arial", "Avenir", "Didot", "Helvetica", "Optima", "Times New Roman"]

	var body: some View {
		
		return ZStack(alignment: .top) {
			Rectangle() // Violet rectangle
				.foregroundColor(Color(hex: 0x5443AF))
				.frame(height:340)
				.cornerRadius(30, corners: [.topLeft, .topRight])
			Rectangle() // White rectangle
				.foregroundColor(.white)
				.frame(height:380)
				.cornerRadius(30, corners: [.topLeft, .topRight])
				.padding(.top, 60)
			HStack { // icons
				Icon(name: "a", index : 1)
				Icon(name: "paintbrush.fill", index : 2)
				Icon(name: "moon.fill", index : 3)
				Icon(name: "bookmark.fill", index : 4)
			}
			.foregroundColor(.white)
			.padding(EdgeInsets(top: 18, leading: 0, bottom: 0, trailing: 0))
				

				ScrollView {
					// Background opacity slider
					if self.appSettings.currentSubMenu == 3 {
						Slider(value: Binding(get: {
							self.appSettings.back
						}, set: { (newVal) in
							self.self.appSettings.back = newVal
						}))
						.frame(height:30)
						.padding(.top, 90)
						.padding(.leading, 20)
						.padding(.trailing, 20)
					}
					// Font family selector
					else if self.appSettings.currentSubMenu == 1 {
						VStack (alignment: .leading, spacing: 5) {
							ForEach(0 ..< fonts.count) {
								Font(name : self.fonts[$0])
							}
						}
						.padding(.leading, 20)
					}
					
					// Font color selection
					if self.appSettings.currentSubMenu == 2 {
						GridStack(rows: 2, columns: 4) { row, col in
							ZStack {
								Rectangle()
									.frame(width : 50, height: 100)
									.foregroundColor(Color(hex: self.appSettings.colors[row*4+col]))
									.cornerRadius(12)
									.padding(10)
								if self.appSettings.colorIndex == row*4+col {
									Image(systemName: "checkmark")
										.foregroundColor(.white)
								}
							}.gesture(
								TapGesture()
								.onEnded { _ in
									self.appSettings.colorIndex = row*4+col
								}
							)
						}
					}
				}
				.padding(.top, 85)
				.padding(.bottom, 60)
			}
		.frame(height: (self.appSettings.settingMenu ? 340 : -540))
		.gesture(
			TapGesture()
			.onEnded { _ in
				return
			}
		)
		.animation(Animation.spring(
			response: 0.5, dampingFraction: 1, blendDuration: 1
		))


	}
}

// Font family label
struct Font : View {
	@EnvironmentObject var appSettings: AppSettings
	let name : String
	var body : some View {
		VStack {
			HStack {
				Button(action: {
					self.appSettings.font = self.name
				}) {
					Text(name).font(.custom(name, size: 18)).foregroundColor(.black)
				}
				if appSettings.font == self.name  {
					Image(systemName: "checkmark").padding(.leading, 8)
				}
				Spacer()
			}
			Rectangle().padding(.trailing, 20).frame(height: 1).foregroundColor(.gray)
		}
		.padding(.bottom, 10)
	.animation(nil)
	}
}

// Submenu icon View
struct Icon : View {
	@EnvironmentObject var appSettings: AppSettings
	let name : String
	let index : Int
	var body: some View {
		Image(systemName: name)
			.resizable().frame(width: 24, height: 24, alignment: .top)
			.padding(.horizontal, 25)
			.opacity((self.appSettings.currentSubMenu == index ? 1 : 0.5))
			.gesture(
				TapGesture()
				.onEnded { _ in
					self.appSettings.currentSubMenu = self.index
					if self.index == 4 {
						self.appSettings.chapter = -1
						self.appSettings.currentSubMenu = 1
						self.appSettings.settingMenu = false
					}
				}
			)
	}
}

// Grid struct
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(slide: CGFloat(1)).environmentObject(AppSettings())
    }
}

