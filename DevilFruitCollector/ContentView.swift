//
//  ContentView.swift
//  DevilFruitCollector
//
//  Created by Osman Kahraman on 2025-11-11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true,
                                           selector: #selector(NSString.localizedCaseInsensitiveCompare))],
        animation: .default)
    private var fruits: FetchedResults<DevilFruit>

    @State private var showAddForm = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(fruits) { fruit in
                    NavigationLink {
                        DetailsView(fruit: fruit)
                    } label: {
                        DevilFruitRowView(fruit: fruit)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .shadow(radius: 3)
                    }
                }
                .onDelete(perform: deleteFruits)
                .listRowBackground(Color.orange.opacity(0.2))
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .background(Color.orange.opacity(0.8))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { EditButton()
                        .tint(.black)
                }
                ToolbarItem {
                    Button(action: addFruit) { Label("Add Item", systemImage: "plus") }
                        .tint(.black)
                }
            }.navigationTitle("Devil Fruits")
            .toolbarBackground(Color.orange.opacity(0.8), for: .navigationBar)
        }
    }
    
    private func addFruit() {
        withAnimation {
            let newFruit = DevilFruit(context: viewContext)
            newFruit.id = UUID()
            newFruit.name = "New Fruit"
            newFruit.type = "Paramecia"
            newFruit.powerDescription = ""
            newFruit.isAwakened = false
            newFruit.dangerLevel = 3.0
            newFruit.firstAppearance = Date()
            newFruit.notes = ""

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteFruits(offsets: IndexSet) {
        withAnimation {
            offsets.map { fruits[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
