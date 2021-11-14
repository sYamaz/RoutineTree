//
//  SyncTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskEditView: View {
    @Binding private var editingTitle:String
    @Binding private var editingDescription:String
    
    init(editingTitle:Binding<String>, editingDescription:Binding<String>){
        
        self._editingTitle = editingTitle
        self._editingDescription = editingDescription
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            TextField("", text: $editingTitle, prompt: nil)
                .font(.title)
            TextEditor(text: $editingDescription)
            Spacer()
        }
        .padding()
    }
}

struct SyncTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        SyncTaskEditView(editingTitle: .constant("Title"), editingDescription: .constant("Description"))
    }
}
