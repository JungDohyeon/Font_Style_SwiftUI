//
//  ContentView.swift
//  Interactive_font
//
//  Created by 정도현 on 2023/03/19.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var myWord: String = "APPLE"
    @State private var letterSpace: CGFloat = 30
    
    @State private var redVal: CGFloat = 0
    @State private var greenVal: CGFloat = 0
    @State private var blueVal: CGFloat = 0
    @State private var myAngle: Double = 0.0
    @State private var fontSize: CGFloat = 30
    
    enum Font: String {
        case Futura = "Futura"
        case Copperplate = "Copperplate"
        case GillSans = "Gill Sans"
        case Palatino = "Palatino"
        case AcademyEngravedLetPlain = "AcademyEngravedLetPlain"
        case AmericanTypewriter_bold = "AmericanTypewriter-Bold"
        case AvenirNext_HeavyItalic = "AvenirNext-HeavyItalic"
        case Chalkduster = "Chalkduster"
        case Zapfino = "Zapfino"
    }
    
    
    let list: [Font] = [.Futura, .Copperplate, .GillSans, .Palatino, .AcademyEngravedLetPlain,  .AvenirNext_HeavyItalic, .AmericanTypewriter_bold, .Chalkduster, .Zapfino]
    
    @State private var fontName: String? = "Futura "
    
    var body: some View {
        ScrollView {
            Spacer()
            
            // 상단 Input, RandomFont 버튼
            HStack {
                Text("Input: ")
                    .font(.system(size: 20))
                    .bold()
                TextEditor(text: $myWord)
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
                
                Spacer()
                
                Button {
                    fontName = list.randomElement()?.rawValue
                } label: {
                    Text("Random Font")
                }
            }
            .padding(10)
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }

            // Text 표시 부분
            Text("\(myWord)")
                .font(.custom(fontName!, size: fontSize))
                .rotationEffect(Angle.degrees(myAngle))
                .gesture(RotationGesture()
                    .onChanged({ angle in
                        self.myAngle = angle.degrees
                    }))
                .tracking(letterSpace)
                .frame(minWidth: 0,
                       idealWidth: 300,
                       maxWidth: .infinity,
                       minHeight: 0,
                       idealHeight: 450,
                       maxHeight: .infinity,
                       alignment: .center)
                .padding(.horizontal, 20)
                .foregroundColor(Color(red: redVal/255, green: greenVal/255, blue: blueVal/255))
                .background(Color(.white))
            
            Text("Font Name: \(fontName!)")
                .frame(width: 370, alignment: .trailing)
                .padding(.bottom, 15)
            
            // Slider Group
            Group {
                Text("(R, G, B) = \(redVal), \(greenVal), \(blueVal)")
                    .font(.system(size: 15))
                
                HStack {
                    Text("R: ")
                    Slider(value: $redVal, in: 0...255) {
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    }
                    .tint(.red)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("G: ")
                    Slider(value: $greenVal, in: 0...255) {
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    }
                    .tint(.green)
                    
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("B: ")
                    Slider(value: $blueVal, in: 0...255) {
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    }
                    .tint(.blue)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                Text("letter Space: \(letterSpace)")
                    .font(.system(size: 15))
                Slider(value: $letterSpace, in: 0...70) {
                    Text("the amount of spacing")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("70")
                }
                .padding(.horizontal, 20)
                
                Text("font Size: \(fontSize)")
                    .font(.system(size: 15))
                Slider(value: $fontSize, in: 10...70) {
                    Text("font size")
                } minimumValueLabel: {
                    Text("10")
                } maximumValueLabel: {
                    Text("70")
                }
                .padding(.horizontal, 20)
                
                Text("Rotate: \(myAngle)")
                    .font(.system(size: 15))
                Slider(value: $myAngle, in: 0...360) {
                    Text("font size")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("360")
                }
                .padding(.horizontal, 20)
            }
        }
    }
}


extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
