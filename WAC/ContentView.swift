//
//  ContentView.swift
//  WAC
//
//  Created by Irine on 07/11/23.
//

import SwiftUI


struct URLImage : View {
    let urlString: String
    @State var categorydata : Data?
    
    
    var body: some View {
        if let data = categorydata , let uiImage = UIImage(data: data){
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:120,height: 70)
                .background(Color.green)
        } else {
            Image(systemName: "")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:70,height: 70)
                .clipShape(Circle())
                .background(Color.white).onAppear {
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL (string:urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _,_ in
            self.categorydata = data
        }
        task.resume()
    }
}
struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var image:UIImage = UIImage()
    @State
    private var searchText =
    ""
    var body: some View {
        
        VStack(alignment: .leading, spacing:0) {
            
            TextField("Search", text: $searchText)
                .padding()
                .frame(height: 45)
            
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 0))
                .padding()
                .overlay {
                    HStack {
                        Button {
                            searchText = ""
                        } label: {
                            Label("clear", systemImage: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .opacity(searchText.isEmpty ? 0 : 1)
                                .padding(30)
                            
                        }
                        
                        .labelStyle(.iconOnly)
                        
                    }
                }
        }
        VStack {
            
            Divider ()
            ScrollView(.horizontal) {
                HStack(alignment: .center,spacing:10){
                    ForEach (viewModel.category, id: \.self) { course in
                        VStack {
                            URLImage(urlString: course.image ?? "")
                            CircleView(label: "\(course.id ?? "")")
                        }
                        .padding(3)
                    }
                }.frame(height:100)
                Divider()
            }
            
            VStack {
                
                ScrollView(.horizontal) {
                    HStack(spacing:10){
                        ForEach (viewModel.banner, id: \.self) { banner in
                            HStack {
                                URLImage(urlString: banner.image ?? "")
                            }
                            .padding(3)
                        }.frame(height: 200)
                    }
                    .onAppear{
                        viewModel.fetch()
                    }
                }
            }
            
            VStack {
                
                Divider ()
                ScrollView(.horizontal) {
                    HStack(alignment: .center,spacing:10){
                        ForEach(0..<10) { index in
                            RectangleView(label: "\(index)")
                        }
                    }.padding()
                    
                }.frame(height:100)
            }
            
            TabView {
                
                Text("")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                Text("")
                    .tabItem {
                        Image(systemName: "categories.fill")
                        Text("Categories")
                    }
                Text("")
                    .tabItem {
                        Image(systemName: "percentage.fill")
                        Text("Offers")
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }
                
                Text("")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Account")
                    }
            }.padding(.top,90)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    struct CircleView: View {
        @State var label:String
        var body: some View {
            VStack{
                Text(label)
            }
        }
    }
    
    struct RectangleView: View {
        @State var label:String
        var body: some View {
            ZStack(){
                Rectangle()
                    .fill(Color.white)
                    .border(.black)
                    .frame(width:158,height: 184)
                Text(label)
                
                Button(action: {}) {
                    Text("ADD")
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                        .background(.green)
                        .frame(width:180,height: 30)
                }
            }
        }
    }
    struct ContentViewTab: View {
        var body: some View {
            
            TabView {
                NavigationView{
                    Color.red
                        .navigationBarTitle("Home", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image(systemName: "star.fill")
                            }
                        }
                        .navigationBarItems(leading: Button("Left") {}, trailing: Button("Right") {})
                }
                .tabItem {
                    VStack{
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
                
                NavigationView{
                    Color.green
                    //                    .item
                        .navigationBarTitle("Second", displayMode: .inline)
                }
                .tabItem {
                    VStack{
                        Image("second")
                        Text("Second")
                    }
                }
            }
        }
    }
}
