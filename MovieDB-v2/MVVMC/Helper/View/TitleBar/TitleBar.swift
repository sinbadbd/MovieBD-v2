//
//  TitleBar.swift
//  ViewKit
//
//  Created by Md. Kamrul Hasan on 11/8/21.
//

import UIKit
 
public class TitleBar: UIView, Reusable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBInspectable public var title: String? { didSet { titleLabel.text = title } }
    
    public var onBackAction: Completion?
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public func setBackButtonVisible(_ visisble: Bool) {
        backButton.isHidden = !visisble
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: TitleBar.nibName, bundle: Bundle(identifier: "com.portonics.MovieDB-v2"))
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func backTapped(_ sender: Any) {
        Log.info()
        onBackAction?()
    }
}
