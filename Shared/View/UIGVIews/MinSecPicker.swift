//
//  MinSecPicker.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/05.
//

import SwiftUI
struct MinSecPicker: View {
    @Binding var min:Int
    @Binding var sec:Int
    @State var interval:DateComponents = .init(minute:0, second:0)
    let formatter:DateComponentsFormatter
    
    init(min:Binding<Int>, sec:Binding<Int>){
        self.formatter = DateComponentsFormatter()
        self._min = min
        self._sec = sec

        interval.minute = min.wrappedValue
        interval.second = sec.wrappedValue
        formatter.zeroFormattingBehavior = .pad
    }
    
    
    var body: some View {
        VStack{
//            HStack(alignment: .center, spacing: nil){
//                Spacer()
//                Picker("min", selection: $min){
//                    ForEach(0..<60){m in
//                        Text(String(m)).tag(m)
//                    }
//                }
//                .pickerStyle(.wheel)
//                .frame(width:70)
//                .compositingGroup()
//                .clipped()
//
//                Text("min")
//
//                Picker("sec", selection: $sec){
//                    ForEach(0..<60){Text(String($0)).tag($0)}
//                }
//                .pickerStyle(.wheel)
//                .frame(width:70)
//                .compositingGroup()
//                .clipped()
//
//                Text("sec")
//                Spacer()
//            }
            
            VStack(alignment: .leading, spacing: nil){
                //MinSecPicker(min: $task.minutes, sec: $task.seconds)
                HStack{
                    Text("minute").font(.caption).foregroundColor(.secondary)
                    Spacer()
                    TextField("minute", value: $min, formatter: NumberFormatter(), prompt: Text("minute")).frame(width:70)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                        .background(.regularMaterial)
                        .keyboardType(.numberPad)
                }
                HStack{
                    Text("second").font(.caption).foregroundColor(.secondary)
                    Spacer()
                    TextField("second", value: $sec, formatter: NumberFormatter()).frame(width: 70).multilineTextAlignment(.trailing)
                        .textFieldStyle(.roundedBorder)
                        .background(.regularMaterial)
                        .keyboardType(.numberPad)
                }
            }.padding()
        }
    }
}

struct MinSecPicker_Previews: PreviewProvider {
    static var previews: some View {
        MinSecPicker(min: .constant(5), sec: .constant(0))
    }
}
