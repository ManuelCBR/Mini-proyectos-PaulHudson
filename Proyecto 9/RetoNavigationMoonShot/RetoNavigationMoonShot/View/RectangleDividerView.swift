//
//  RectangleDividerView.swift
//  RetoNavigationMoonShot
//
//  Created by Manuel Bermudo on 22/6/25.
//

import SwiftUI

struct RectangleDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectangleDividerView()
}
