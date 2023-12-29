//
//  NoteFormView.swift
//  DanielKeep
//
//  Created by Dani Benet on 29/12/23.
//

import SwiftUI

struct NoteFormView: View {
    @Environment(\.modelContext) var context

    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
                .font(.title2)
            TextField("Description", text: $description,  axis: .vertical)
                .lineLimit(nil)
        }
        .formStyle(.columns)
        .padding(.horizontal)
    }
}

#Preview {
    NoteFormView(title: .constant(""), description: .constant(""))
}
