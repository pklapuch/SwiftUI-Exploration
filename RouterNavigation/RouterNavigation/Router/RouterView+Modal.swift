import SwiftUI

extension View {
    func modal<Item, Content>(
        item: Binding<Item?>,
        content: @escaping (Item) -> Content,
        onDismiss: (() -> Void)? = nil
    ) -> some View where Item: Identifiable, Content: View {
        ZStack(alignment: .center) {
            self

            if let wrappedItem = item.wrappedValue {
                makeModalBody(
                    item: wrappedItem,
                    content: content(wrappedItem),
                    onClose: { item.wrappedValue = nil }
                )
            }
        }
    }

    @ViewBuilder private func makeModalBody<Item: Identifiable, Content: View>(
        item: Item,
        content: Content,
        onClose: @escaping () -> Void
    ) -> some View {
        Color.black.opacity(0.5).ignoresSafeArea()

        VStack(spacing: 0) {
            HStack {
                Button(action: onClose, label: { Text("Close") })
                Spacer()
            }
            .frame(height: 50)
            .padding(.horizontal, 12)

            content
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        .padding(.horizontal, 16)
    }
}

