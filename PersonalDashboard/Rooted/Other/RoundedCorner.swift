struct RoundedCorner: Shape {
    var radius: CGFloat = 15.0
	var corners: UIRectCorner = .topRight

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
