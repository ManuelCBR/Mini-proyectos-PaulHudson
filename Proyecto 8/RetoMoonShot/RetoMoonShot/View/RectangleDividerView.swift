//
//  RectangleDividerView.swift
//  RetoMoonShot
//
//  Created by Manuel Bermudo on 1/6/25.
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
