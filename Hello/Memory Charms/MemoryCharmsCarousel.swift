import SwiftUI
import ZTronCarousel
import UIKit

import ZTronSerializable
/*
@MainActor public final class MemoryCharmsCarousel: CarouselPageWithTopbar {
    private let prizeView: UIViewController
    
    public init() {
        self.prizeView = UIHostingController(
            rootView: Accordion(
                isExpanded: .constant(true),
                header: {
                    HStack(alignment: .center, spacing: 20) {
                        Image(systemName: "trophy")
                            .font(.system(size: 20))
                            .foregroundStyle(
                                Color(UIColor(red: 216.0/255.0, green: 176.0/255.0, blue: 74.0/255.0, alpha: 1.0))
                            )
                        
                        Text("Reward")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.8)
                    }
                },
                content: {
                    Text("Praesent neque purus, viverra non eleifend sit amet, cursus vitae mauris. Sed tincidunt neque ac felis pellentesque egestas. Sed at neque scelerisque, fermentum sem ac, porttitor augue. Maecenas venenatis enim vel porttitor efficitur. Sed non orci felis. Vivamus vitae enim euismod lacus maximus vestibulum. Donec eget volutpat lorem. Curabitur vestibulum nisi quam, nec elementum orci bibendum vitae. Proin euismod ex condimentum facilisis vehicula. Pellentesque varius blandit ipsum, ut tincidunt enim tempor eget. Pellentesque vehicula pretium ex, ut gravida est hendrerit id. Suspendisse potenti. Donec diam quam, bibendum et finibus pellentesque, luctus pulvinar augue. Phasellus eget nunc ultrices, ornare metus sed, convallis enim.")
                        .font(.callout)
                }
            )
            .withBackgroundColor(Color(UIColor.init(red: 1.0, green: 240.0/255.0, blue: 204.0/255.0, alpha: 1.0)))
            .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
            .padding()
        )
        
        super.init(
            foreignKeys: .init(
                tool: "memory charms",
                tab: "side quests",
                map: "rave in the redwoods",
                game: "infinite warfare"
            ),
            with: DefaultZTronMediaFactory()
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    
    
        self.embeddingScrollView.addSubview(prizeView.view)
        prizeView.didMove(toParent: self)
        
        prizeView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prizeView.view.topAnchor.constraint(equalTo: super.captionView.bottomAnchor, constant: 0),
            prizeView.view.leftAnchor.constraint(equalTo: super.thePageVC.view.leftAnchor),
            prizeView.view.rightAnchor.constraint(equalTo: super.thePageVC.view.rightAnchor),
        ])
        
        prizeView.view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        prizeView.view.backgroundColor = .clear
    
        super.embeddingScrollView.backgroundColor = .red
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("FRAME: \(super.embeddingScrollView.frame), CONTENTSIZE: \(super.embeddingScrollView.contentSize)")
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            if UIDevice.current.orientation.isValidInterfaceOrientation {
                if UIDevice.current.orientation.isPortrait {
                    self.prizeView.view.isHidden = false
                } else {
                    self.prizeView.view.isHidden = true
                }
            }
        } completion: { @MainActor  _ in
            self.prizeView.view.invalidateIntrinsicContentSize()
        }
    }
    
}
*/
