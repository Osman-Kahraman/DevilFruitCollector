//
//  SwiftUIView.swift
//  DevilFruitCollector
//
//  Created by Osman Kahraman on 2025-11-12.
//

import SwiftUI
import CoreData

struct DetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var fruit: DevilFruit

    @State private var name: String = ""
    @State private var type: String = "Paramecia"
    @State private var powerDescription: String = ""
    @State private var isAwakened: Bool = false
    @State private var dangerLevel: Double = 3.0
    @State private var firstAppearance: Date = Date()
    @State private var notes: String = ""

    let types = ["Paramecia", "Logia", "Zoan", "Ancient Zoan", "Mythical Zoan", "SMILE"]

    init(fruit: DevilFruit) {
        self.fruit = fruit
    }

    var body: some View {
        Form {
            Section("Basic Info") {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(radius: 3)

                    VStack(alignment: .leading, spacing: 8) {
                        TextField("What is this fruit called?", text: $name)
                        Picker("Type", selection: $type) {
                            ForEach(types, id: \.self) { t in
                                Text(t)
                            }
                        }
                        Toggle("Awakened", isOn: $isAwakened)
                    }
                    .padding()
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.orange.opacity(0.2))

            Section("Power") {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(radius: 3)

                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .topLeading) {
                            if powerDescription.isEmpty {
                                Text("Describe the true power hidden within this fruit…")
                                    .foregroundColor(.gray)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 5)
                            }
                            TextEditor(text: $powerDescription)
                                .frame(minHeight: 100)
                        }
                        VStack {
                            HStack {
                                Text("Danger Level")
                                Spacer()
                                Text(String(format: "%.1f", dangerLevel))
                            }
                            Slider(value: $dangerLevel, in: 1...5, step: 0.5)
                        }
                    }
                    .padding()
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.orange.opacity(0.2))

            Section("Story") {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(radius: 3)

                    VStack(alignment: .leading, spacing: 8) {
                        DatePicker("First Appearance", selection: $firstAppearance, displayedComponents: .date)
                        ZStack(alignment: .topLeading) {
                            if notes.isEmpty {
                                Text("Describe the abilities awakened by this Devil Fruit…")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 8)
                            }
                            TextEditor(text: $notes)
                                .frame(minHeight: 80)
                        }
                    }
                    .padding()
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.orange.opacity(0.2))
        }
        .scrollContentBackground(.hidden)
        .background(Color.orange.opacity(0.8))
        .navigationTitle(fruit.name ?? "Devil Fruit")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            name = fruit.name ?? ""
            type = fruit.type ?? "Paramecia"
            powerDescription = fruit.powerDescription ?? ""
            isAwakened = fruit.isAwakened
            dangerLevel = fruit.dangerLevel
            firstAppearance = fruit.firstAppearance ?? Date()
            notes = fruit.notes ?? ""
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveChanges()
                }
                .tint(.black)
            }
        }
        .toolbarBackground(Color.orange.opacity(0.8), for: .navigationBar)
        
    }

    private func saveChanges() {
        fruit.name = name
        fruit.type = type
        fruit.powerDescription = powerDescription
        fruit.isAwakened = isAwakened
        fruit.dangerLevel = dangerLevel
        fruit.firstAppearance = firstAppearance
        fruit.notes = notes

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Save error:", error)
        }
    }
}

#Preview {
    let ctx = PersistenceController.preview.container.viewContext
    let request = NSFetchRequest<DevilFruit>(entityName: "DevilFruit")
    let fruits = (try? ctx.fetch(request)) ?? []
    return NavigationStack {
        if let first = fruits.first {
            DetailsView(fruit: first)
        } else {
            Text("No preview data")
        }
    }
    .environment(\.managedObjectContext, ctx)
}
