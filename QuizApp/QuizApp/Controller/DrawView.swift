//
//  DrawView.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/23.
//

import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate {
    var currentLines = [NSValue: Line]()
    var finishedLines = [Line]()
    var finishedLinesColor = [Int]()
    var savedLines: [Line]!
    var savedLinesColor: [Int]!
    var setColor: Int = 0
    
    var selectedLineIndex: Int? {
        didSet {
            if selectedLineIndex == nil {
                let menu = UIMenuController.shared
                menu.hideMenu(from: self)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawView.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawView.tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(DrawView.longPress(_:)))
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DrawView.moveLine(_:)))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer) {
        print("Recognized a tap")
        
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = indexOfLine(at: point)
        
        // Get the menu controller
        let menu = UIMenuController.shared
        if selectedLineIndex != nil {
            // Make DrawView the target of menu item action messages
            becomeFirstResponder()
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(DrawView.deleteLine(_:)))
            let colorBlack = UIMenuItem(title: "Black", action: #selector(DrawView.changeLineColorBlack(_:)))
            let colorYellow = UIMenuItem(title: "Yellow", action: #selector(DrawView.changeLineColorYellow(_:)))
            let colorGray = UIMenuItem(title: "Gray", action: #selector(DrawView.changeLineColorGray(_:)))
            let colorBlue = UIMenuItem(title: "Blue", action: #selector(DrawView.changeLineColorBlue(_:)))
            menu.menuItems = [deleteItem, colorBlack, colorYellow, colorGray, colorBlue]
            
            // Where menue come form and show
            let targetRec = CGRect(x: point.x, y: point.y, width: 2, height: 2)
            menu.showMenu(from: self, rect: targetRec)
        } else {
            // Hide menu if no line selected
            menu.hideMenu(from: self)
        }
        setNeedsDisplay()
    }
    
    @objc func changeLineColorBlack(_ sender: UIMenuController) {
        if let index = selectedLineIndex {
            finishedLinesColor[index] = 1
        }
    }
    @objc func changeLineColorYellow(_ sender: UIMenuController) {
        if let index = selectedLineIndex {
            finishedLinesColor[index] = 2
        }
    }
    @objc func changeLineColorGray(_ sender: UIMenuController) {
        if let index = selectedLineIndex {
            finishedLinesColor[index] = 3
        }
    }
    @objc func changeLineColorBlue(_ sender: UIMenuController) {
        if let index = selectedLineIndex {
            finishedLinesColor[index] = 4
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @objc func deleteLine(_ sender: UIMenuController) {
//        let alertController = UIAlertController(title: "Confirm delete?", message: "This would delete the selected line and cannot be undo", preferredStyle: .alert)
//        let confirmDeleteAction = UIAlertAction(title: "Delete", style: .destructive) { [self]_ in
            if let index = selectedLineIndex {
                finishedLines.remove(at: index)
                finishedLinesColor.remove(at: index)
                selectedLineIndex = nil
                setNeedsDisplay()
            }
        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        alertController.addAction(confirmDeleteAction)
//        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//    }
    
    
    @objc func doubleTap(_ gestureRecognizer: UIGestureRecognizer) {
//        print("Recognized a double tap")
        selectedLineIndex = nil
        let alertController = UIAlertController(title: "Confirm delete?", message: "This would delete all lines and cannot be undo", preferredStyle: .alert)
        
        let confirmDeleteAction = UIAlertAction(title: "Delete", style: .destructive) { [self]_ in
            currentLines.removeAll()
            finishedLines.removeAll()
            setNeedsDisplay()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmDeleteAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func longPress(_ gestureRecognizer: UIGestureRecognizer) {
//        print("Recognized a long press")
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: self)
            selectedLineIndex = indexOfLine(at: point)
            let menu = UIMenuController.shared
            if selectedLineIndex == nil {
                becomeFirstResponder()
                let colorBlack = UIMenuItem(title: "Black", action: #selector(DrawView.setPenColorBlack(_:)))
                let colorYellow = UIMenuItem(title: "Yellow", action: #selector(DrawView.setPenColorYellow(_:)))
                let colorGray = UIMenuItem(title: "Gray", action: #selector(DrawView.setPenColorGray(_:)))
                let colorBlue = UIMenuItem(title: "Blue", action: #selector(DrawView.setPenColorBlue(_:)))
                menu.menuItems = [colorBlack, colorYellow, colorGray, colorBlue]
                
                // Where menue come form and show
                let targetRec = CGRect(x: point.x, y: point.y, width: 2, height: 2)
                menu.showMenu(from: self, rect: targetRec)
            }
        }
        setNeedsDisplay()
    }
    
    @objc func setPenColorBlack(_ sender: UIMenuController){
        setColor = 1
    }
    @objc func setPenColorYellow(_ sender: UIMenuController){
        setColor = 2
    }
    @objc func setPenColorGray(_ sender: UIMenuController){
        setColor = 3
    }
    @objc func setPenColorBlue(_ sender: UIMenuController){
        setColor = 4
    }
    
    @objc func moveLine(_ gestureRecognizer: UIPanGestureRecognizer) {
//        print("Recognized a pan")
        if let index = selectedLineIndex {
            if gestureRecognizer.state == .changed {
                let translation = gestureRecognizer.translation(in: self)
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                // Redraw the screen
                setNeedsDisplay()
            }
        } else {
            return
        }
    }
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round

        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        if savedLines.count != 0 && finishedLines.count == 0{
            for (index, line) in savedLines.enumerated() {
                finishedLines.append(line)
                finishedLinesColor.append(savedLinesColor[index])
            }
            savedLines.removeAll()
        }
        
        // Finished line in black
        for (index, line) in finishedLines.enumerated() {
            let colorNumber = finishedLinesColor[index]
            switch colorNumber {
            case 0:
                finishedLineColor.setStroke()
            case 1:
                UIColor.black.setStroke()
            case 2:
                UIColor.yellow.setStroke()
            case 3:
                UIColor.gray.setStroke()
            case 4:
                UIColor.blue.setStroke()
            default:
                finishedLineColor.setStroke()
            }
            stroke(line)
            finishedLineColor.setStroke()
        }
        
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            // current line being drawing, red
            stroke(line)
        }
        
        if let index = selectedLineIndex {
            UIColor.green.setStroke()
            let selectedLine = finishedLines[index]
            stroke(selectedLine)
        }
    }
    
    func indexOfLine(at point: CGPoint) -> Int? {
        for (index, line) in finishedLines.enumerated() {
            // Find a line close to point
            let begin = line.begin
            let end = line.end
            // Check a few points on the line
            for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                if hypot(x - point.x, y - point.y) < 20.0 {
                    return index
                }
            }
        }
        // If nothing is close enough to the tapped point, then we did not select a line
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key]{
                line.end = touch.location(in: self)
                finishedLines.append(line)
                finishedLinesColor.append(setColor)
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DrawView {
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

var moveRecognizer: UIPanGestureRecognizer!

