//
//  DevilFruitRowView.swift
//  DevilFruitCollector
//
//  Created by Osman Kahraman on 2025-11-14.
//

import SwiftUI
import CoreData

struct DevilFruitRowView: View {
    @ObservedObject var fruit: DevilFruit

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(fruit.name ?? "Unknown Fruit")
                    .font(.headline)
                Text(fruit.type ?? "Unknown Type")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(String(format: "%.1f / 5.0", fruit.dangerLevel))
                    .font(.subheadline)
                Image(systemName: fruit.isAwakened ? "flame.fill" : "flame")
                    .foregroundStyle(fruit.isAwakened ? .red : .gray)
            }
        }
    }
}
