//
//  Home.swift
//  LittleLemon
//
//  Created by Marco Eckey on 28.09.23.
//

import Foundation
import SwiftUI


struct Menu : View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var isLoggedIn : Bool = false
    @State var searchText : String = ""
    
    func buildPredicate() -> NSPredicate {
        if searchText.count == 0 {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    func sortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector:  #selector(NSString.localizedStandardCompare))]
    }
    func getMenuDate() {
        PersistenceController.shared.clear()
        let urlString  : String = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: url) {data , response, error in
            if let d = data {
                let decoder = JSONDecoder()
                do {
                    let menu = try decoder.decode(MenuList.self, from: d)
                    
                    for menuItem in menu.menu {
                        let dish = Dish(context: viewContext)
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.title = menuItem.title
                    }
                    try? viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        dataTask.resume()
    }
    var body : some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("Just a little restaurant app")
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: sortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title!)  \(dish.price! )")
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.image?.resizable()
                            }
                            .frame(width: 100, height: 100)
                        }
                        
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
            getMenuDate()
        }
        .navigationBarBackButtonHidden(true)
    }
}
struct Home : View {
    let persistence = PersistenceController()
    var body : some View {
        GeometryReader { geo in
            TabView {
                Menu()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                UserProfile()
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
            }
        }
        
    }
}
