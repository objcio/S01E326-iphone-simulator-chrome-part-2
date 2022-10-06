//
//  ContentView.swift
//  FakeSimulator
//
//  Created by Chris Eidhof on 05.10.22.
//

import SwiftUI

struct Device {
    var size: CGSize
    var bezelWidth: CGFloat = 10
    var topSafeAreaHeight: CGFloat = 47
    var bottomSafeAreaHeight: CGFloat = 34

    static let iPhone13 = Device(size: .init(width: 390, height: 844))
}

struct PhoneModifier: ViewModifier {
    var device: Device
    var colorScheme: ColorScheme = .light

    var deviceShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 40, style: .continuous)
    }

    var topBar: some View {
        HStack {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                Text(context.date, format: Date.FormatStyle(date: .none, time: .shortened))
                    .fontWeight(.medium)
                    .padding(.leading, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Notch()
                .frame(maxHeight: .infinity, alignment: .top)
            HStack {
                Image(systemName: "wifi")
                Image(systemName: "battery.75")
            }
            .padding(.trailing, 24)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    var homeIndicator: some View {
        Capsule(style: .continuous)
            .frame(width: 160, height: 5)
            .frame(height: 13, alignment: .top)
    }

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .top, spacing: 0) {
                topBar
                    .frame(height: device.topSafeAreaHeight)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                homeIndicator
                    .frame(height: device.bottomSafeAreaHeight, alignment: .bottom)
            }
            .frame(width: device.size.width, height: device.size.height)
            .background(.background)
            .clipShape(deviceShape)
            .overlay {
                deviceShape
                    .inset(by: -device.bezelWidth/2)
                    .stroke(.black, lineWidth: device.bezelWidth)
            }
            .padding(device.bezelWidth)
            .colorScheme(colorScheme)
    }
}


struct ContentView: View {
    var body: some View {
        Color.yellow
            .edgesIgnoringSafeArea(.all)
        .modifier(PhoneModifier(device: .iPhone13))
        .padding()
        .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
