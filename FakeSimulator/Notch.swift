import SwiftUI

struct CornerShape: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.addRoundedRect(in: rect, cornerSize: .init(width: cornerRadius, height: cornerRadius), style: .continuous)
            p.addRect(rect)
        }
    }
}

struct Notch: View {
    var height: CGFloat = 34
    var topRadius: CGFloat = 8

    var body: some View {
        let topCorner =         CornerShape(cornerRadius: topRadius)
            .fill(style: .init(eoFill: true))
            .frame(width: topRadius*2, height: topRadius*2)
            .frame(width: topRadius, height: topRadius, alignment: .topTrailing)
            .clipped()

        HStack(alignment: .top, spacing: 0) {
            topCorner
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(height: height*2)
                .frame(width: 162, height: height, alignment: .bottom)
            topCorner
                .scaleEffect(x: -1)
        }
    }
}

struct Notch_Preview: PreviewProvider {
    static var previews: some View {
        Notch()
    }
}
