import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let data: String
    var size: CGFloat = 220
    var foregroundColor: Color = .black
    var backgroundColor: Color = .white
    var cornerRadius: CGFloat = 20

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(backgroundColor)
                .frame(width: size, height: size)

            if let image = generateQRCode(from: data) {
                Image(uiImage: image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size - 40, height: size - 40)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
        .frame(width: size, height: size)
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        guard let data = string.data(using: .utf8) else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")

        guard let outputImage = filter.outputImage else { return nil }

        // Scale up the QR code for crisp rendering
        let scaleX = (size - 40) * UIScreen.main.scale / outputImage.extent.size.width
        let scaleY = (size - 40) * UIScreen.main.scale / outputImage.extent.size.height
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: "0C111D").ignoresSafeArea()
            QRCodeView(data: "LOOFY-PAT-LEE-8240")
                .shadow(color: .white.opacity(0.1), radius: 20)
        }
    }
}
