// Subviews
let logoImageView = UIImageView()
let welcomeLabel = UILabel()
let dismissButton = UIButton()

// Add Subviews & Set view's translatesAutoresizingMaskIntoConstraints to false
addSubviewsUsingAutoLayout(logoImageView, welcomeLabel, dismissButton)

// Set Constraints
logoImageView.topAnchor.constrain(to: topAnchor, with: 12)
logoImageView.centerXAnchor.constrain(to: centerXAnchor)
logoImageView.widthAnchor.constrain(to: 50)
logoImageView.heightAnchor.constrain(to: 50)

dismissButton.leadingAnchor.constrain(.greaterThanOrEqual, to: leadingAnchor, with: 12)
dismissButton.trailingAnchor.constrain(.lessThanOrEqual, to: trailingAnchor, with: -12)
dismissButton.bottomAnchor.constrain(to: bottomAnchor)
dismissButton.widthAnchor.constrain(to: 320, prioritizeAs: .defaultHigh + 1)

welcomeLabel.topAnchor.constrain(to: logoImageView.bottomAnchor, with: 12)
welcomeLabel.bottomAnchor.constrain(.greaterThanOrEqual, to: dismissButton.topAnchor, with: 12)
welcomeLabel.leadingAnchor.constrain(to: dismissButton.leadingAnchor)
welcomeLabel.trailingAnchor.constrain(to: dismissButton.trailingAnchor)
