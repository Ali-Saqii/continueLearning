//
//  sort:filter:maping.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 14/01/2026.
//

import SwiftUI
import Observation

// MARK: - Student Model

struct Student: Identifiable {
    let id = UUID()
    var name: String
    var marks: Int
    var address: String
    var imageURL: String
    
    var initialise: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: name) else {
            return nil
            
        }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
}

// MARK: - Observable Store

@Observable
class StudentStore {
    var students: [Student] = []
    var sortedArray:[Student] = []
    var mapedArray: [String] = []
    init() {
        
        getStudents()
    }
    
    func getStudents() {
     let student1 =    Student(name: "Ali", marks: 85, address: "Lahore", imageURL: "https://picsum.photos/id/1005/200/200")
         let student2 =     Student(name: "Ahmed", marks: 92, address: "Karachi", imageURL: "https://picsum.photos/id/1011/200/200")
         let student3 =     Student(name: "Sara", marks: 78, address: "Islamabad", imageURL: "https://picsum.photos/id/1027/200/200")
         let student4 =   Student(name: "Hassan", marks: 88, address: "Multan", imageURL: "https://picsum.photos/id/1035/200/200")
         let student5 =   Student(name: "Ayesha", marks: 91, address: "Faisalabad", imageURL: "https://picsum.photos/id/1041/200/200")
         let student6 =   Student(name: "Zain", marks: 80, address: "Rawalpindi", imageURL: "https://picsum.photos/id/1050/200/200")
         let student7 =   Student(name: "Fatima", marks: 95, address: "Peshawar", imageURL: "https://picsum.photos/id/1062/200/200")
         let student8 =   Student(name: "Omar", marks: 77, address: "Quetta", imageURL: "https://picsum.photos/id/1070/200/200")
         let student9 =  Student(name: "Hina", marks: 84, address: "Sialkot", imageURL: "https://picsum.photos/id/1080/200/200")
         let student10 =     Student(name: "Bilal", marks: 89, address: "Gujranwala", imageURL: "https://picsum.photos/id/1085/200/200")
         let student11 =  Student(name: "Maryam", marks: 93, address: "Hyderabad", imageURL: "https://picsum.photos/id/1090/200/200")
         let student12 =  Student(name: "Usman", marks: 81, address: "Sukkur", imageURL: "https://picsum.photos/id/1095/200/200")
        
        self.students.append(contentsOf: [
            student1,
            student2,
            student3,
            student4,
            student5,
            student6,
            student7,
            student8,
            student9,
            student10,
            student11,
            student12
        ])
    }
    func getSortedArry(sortby:Bool) {
        
        if sortby == true {
//            sortedArray = students.sorted(by: { (student1, student2 )  -> Bool in
//                return student1.marks > student2.marks
//                
//            })
            sortedArray = students.sorted(by: {$0.marks > $1.marks})
        }else if sortby == false {
//            sortedArray = students.sorted(by: { (student1, student2 )  -> Bool in
//                return student1.marks < student2.marks
//                
//            })
            sortedArray = students.sorted(by: {$0.marks < $1.marks})
        }else{
            sortedArray = students
        }
    }
    func getFilteredArray() {
//       sortedArray = students.filter({ (Student) -> Bool in
//            return Student.marks > 90
//        })
        sortedArray = students.filter({$0.marks > 90})
    }
    func getMapedArray() {
//        mapedArray = students.compactMap({ (Student) -> String? in
//            return Student.name
//        })
        mapedArray = students.compactMap({$0.name})
    }
}


struct StudentListView: View {

    @State private var store = StudentStore()
    @State var sortingByMarks:Bool = false
    @State var mixarray = true
    @State var MapedArray = false
    var body: some View {
        NavigationStack {
            HStack{
                Button("filter by marks> 70", action: {
                    withAnimation(.easeIn(duration: 0.5)) {
                        sortingByMarks = false
                       mixarray = false
                        store.getFilteredArray()
                    }
                }).buttonStyle(.bordered)
                Spacer()
                Button("names of an students", action: {
                    withAnimation(.easeIn(duration: 0.5)) {
                        sortingByMarks = false
                       mixarray = false
                        store.getMapedArray()
                    }
                }).buttonStyle(.bordered)
            }.frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.horizontal)
            List {
                ForEach(
                mixarray ?$store.students:$store.sortedArray
                    
                ) { $student in
                    NavigationLink {
                        StudentDetailView(student: $student)
                    } label: {
                        HStack(spacing: 16) {

                            AsyncImage(url: URL(string: student.imageURL)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else if phase.error != nil {
                                    Text(student.initialise ?? "")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 50, height: 50)
                                        .background(
                                            Circle()
                                                .fill(.secondary.opacity(0.6))
                                        )
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text(student.name)
                                    .font(.headline)
                                Text("Marks: \(student.marks)")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: {
                mixarray = true
            })
            .navigationTitle("Students")
            .toolbar(content: {
                ToolbarItem(placement:.topBarTrailing) {
                    Menu {
                        Button("sort by higestMarks", action: {
                            withAnimation(.easeIn(duration: 1)) {
                                sortingByMarks = true
                                mixarray = false;
                            }
                            store.getSortedArry(sortby: sortingByMarks)
                           
                        }
                        )
                        Button("sort by LowestMarks", action: {
                            withAnimation(.easeIn(duration: 1)) {
                                sortingByMarks = false
                                mixarray = false;
                            }
                            store.getSortedArry(sortby: sortingByMarks)
                        }
                        )
                    } label: {
                        
                        Image(systemName:"arrow.up.arrow.down")
                            .font(.callout)
                          
                    }
  
                }
            })
            .sheet(isPresented: $MapedArray) {
            }
        }
    }
}
struct StudentDetailView: View {

    @Binding var student: Student

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack(spacing:50) {
                AsyncImage(url: URL(string: student.imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Text(student.initialise ?? "")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 200)
                            .background(
                                Circle()
                                    .fill(.secondary.opacity(0.6))
                            )
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .padding(.leading)
                .padding(.top)
                
                Text(student.name)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            // 🔹 Student Info List
            List {
                Section("Student Info") {

                    // Name → Edit Name
                    NavigationLink {
                        UpdateNameView(student: $student)
                    } label: {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text(student.name)
                                .foregroundStyle(.secondary)
                        }
                    }

                    // Marks → Edit Marks
                    NavigationLink {
                        UpdateMarksView(student: $student)
                    } label: {
                        HStack {
                            Text("Marks")
                            Spacer()
                            Text("\(student.marks)")
                                .foregroundStyle(.secondary)
                        }
                    }

                    // Address → Edit Address
                    NavigationLink {
                        UpdateAddressView(student: $student)
                    } label: {
                        HStack {
                            Text("Address")
                            Spacer()
                            Text(student.address)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Details")
     
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Update Name View

struct UpdateNameView: View {
    @Binding var student: Student
    @Environment(\.dismiss) var dismiss
    @State private var name = ""

    var body: some View {
        VStack(spacing: 30) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Name")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                    TextField("Enter new name", text: $name)
                        .textFieldStyle(.plain)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemGray6))
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                )
            }
            .padding(.horizontal)
            
            Button {
                if !name.isEmpty {
                    student.name = name
                    dismiss()
                }
            } label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.orange, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Update Name")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            name = student.name
        }
    }
}

// MARK: - Update Marks View

struct UpdateMarksView: View {
    @Binding var student: Student
    @Environment(\.dismiss) var dismiss
    @State private var marks = ""

    var body: some View {
        VStack(spacing: 30) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Marks")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "number")
                        .foregroundColor(.green)
                    TextField("Enter new marks", text: $marks)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.plain)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemGray6))
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                )
            }
            .padding(.horizontal)
            
            Button {
                if let value = Int(marks) {
                    student.marks = value
                    dismiss()
                }
            } label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Update Marks")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            marks = "\(student.marks)"
        }
    }
}

// MARK: - Update Address View

struct UpdateAddressView: View {
    @Binding var student: Student
    @Environment(\.dismiss) var dismiss
    @State private var address = ""

    var body: some View {
        VStack(spacing: 30) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Address")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.orange)
                    TextField("Enter new address", text: $address)
                        .textFieldStyle(.plain)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemGray6))
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                )
            }
            .padding(.horizontal)
            
            Button {
                if !address.isEmpty {
                    student.address = address
                    dismiss()
                }
            } label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.pink, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Update Address")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            address = student.address
        }
    }
}

#Preview {
    StudentListView()
}
