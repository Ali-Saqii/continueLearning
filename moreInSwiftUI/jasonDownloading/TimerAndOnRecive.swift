//
//  TimerAndOnRecive.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 02/02/2026.
//

import SwiftUI
import UIKit
internal import Combine

//MARK: old way to user timer

class TimerViewModel: ObservableObject {
    @Published var counter = 0
    var timer: Timer?

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.counter += 1
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct OldTimerView: View {
    @StateObject var vm = TimerViewModel()

    var body: some View {
        VStack {
            Text("Counter: \(vm.counter)")
            Button("Start") { vm.startTimer() }
            Button("Stop") { vm.stopTimer() }
        }
    }
}

//MARK: current time timer
struct TimerAndOnRecive: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate : Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.purple,.blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            
            VStack {
                Text("current date timer".capitalized)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(dateFormatter.string(from: currentDate))
                    .font(.system(size: 100,weight: .semibold,design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
        }.onReceive(timer) { value in
            currentDate = value
        }
        
    }
}

//MARK: countdown timer


struct countDOwnView:View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    var body: some View {
        
        ZStack {
            RadialGradient(colors: [.purple,.blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            VStack {
                Text("count down timer".capitalized)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(finishedText ?? "\(count)")
                    .font(.system(size: 100,weight: .semibold,design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
        }.onReceive(timer) { _ in
            if count <= 1{
                finishedText = "Wow!"
            }else {
                count -= 1
            }
        }
    }
}
// count down to date
struct counDownToDate:View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute) minutes, \(second) seconds"
    }
    var body: some View {
        
        ZStack {
            RadialGradient(colors: [.purple,.blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            VStack {
                Text("count down to date".capitalized)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(timeRemaining)
                    .font(.system(size: 100,weight: .semibold,design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
        }.onReceive(timer) { _ in
           updateTimeRemaining()
        }
    }
}
//animate counter

struct animateEWithTImer:View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count:Int = 0
    var body: some View {
        
        ZStack {
            RadialGradient(colors: [.purple,.blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            VStack {
                Text("animation with Timer".capitalized)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                HStack {
                    Circle()
                        .offset(y: count == 1 ? -20 : 0)
                    Circle()
                        .offset(y: count == 2 ? -20 : 0)
                    Circle()
                        .offset(y: count == 3 ? -20 : 0)
                    Circle()
                        .offset(y: count == 4 ? -20 : 0)
                }
            }
        }.onReceive(timer) { _ in
            withAnimation(.easeIn(duration: 1.0)) {
                count = count == 4 ? 0 : count + 1
            }
        }
    }
        
    }
struct animateEWithTImer2:View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count:Int = 0
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count,
                    content:  {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        })
    }
}
#Preview {
//    TimerAndOnRecive()
//    OldTimerView()
//    countDOwnView()
//    counDownToDate()
    animateEWithTImer()
    animateEWithTImer2()
}
