//
//  CircleProgressStyle.swift
//  
//
//  Created by François Boulais on 18/07/2022.
//

import SwiftUI

public struct CircleProgressStyle: ProgressViewStyle {
    private struct Arc: Shape {
        let gapDegree: CGFloat
        let gapPosition: GapPosition
        
        private var startAngle: Angle {
            if gapDegree == 0 {
                return .zero
            } else {
                return gapPosition.startAngle + .degrees(gapDegree / 2)
            }
        }
        
        private var endAngle: Angle {
            if gapDegree == 0 {
                return .degrees(360)
            } else {
                return gapPosition.startAngle - .degrees(gapDegree / 2) + .degrees(360)
            }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.addArc(
                center: .init(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
            
            return path
        }
    }
    
    public enum Status {
        case success
        case exception
        case normal
    }
    
    public enum GapPosition {
        case top, bottom, left, right
        
        var startAngle: Angle {
            switch self {
            case .top:
                return .degrees(0)
            case .bottom:
                return .degrees(180)
            case .left:
                return .degrees(270)
            case .right:
                return .degrees(90)
            }
        }
    }
    
    let size: ProgressSize
    let showInfo: Bool
    let status: Status
    let strokeColor: ProgressColor?
    let strokeLinecap: CGLineCap
    let strokeWidth: CGFloat
    let success: ProgressSuccess?
    let trailColor: Color
    
    let gapDegree: CGFloat
    let gapPosition: GapPosition
    
    public init(
        size: ProgressSize = .default,
        status: Status = .normal,
        strokeLinecap: CGLineCap = .round,
        showInfo: Bool = true,
        trailColor: Color = Preferences.progressRemainingColor,
        strokeColor: ProgressColor? = nil,
        strokeWidth: CGFloat = 6,
        success: ProgressSuccess? = nil,
        gapDegree: CGFloat = 0,
        gapPosition: GapPosition = .bottom
    ) {
        self.size = size
        self.status = status
        self.strokeLinecap = strokeLinecap
        self.showInfo = showInfo
        self.trailColor = trailColor
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.success = success
        self.gapDegree = gapDegree
        self.gapPosition = gapPosition
    }
    
    private var strokeStyle: StrokeStyle {
        .init(lineWidth: strokeWidth, lineCap: strokeLinecap)
    }
    
    private func progressColor(progress: CGFloat) -> Color {
        switch status {
        case .success:
            return Preferences.successColor
        case .exception:
            return Preferences.errorColor
        case .normal where isSuccess(progress: progress):
            return Preferences.successColor
        case .normal:
            return Preferences.progressDefaultColor
        }
    }
    
    private func textColor(progress: CGFloat) -> Color {
        switch status {
        case .success:
            return Preferences.successColor
        case .exception:
            return Preferences.errorColor
        case .normal where isSuccess(progress: progress):
            return Preferences.successColor
        case .normal:
            return Preferences.progressTextColor
        }
    }
    
    private func isSuccess(progress: CGFloat) -> Bool {
        if status == .success {
            return true
        } else if progress == 1 && success == nil {
            return true
        } else {
            return false
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0

        ZStack(alignment: .center) {
            Group {
                Arc(gapDegree: gapDegree, gapPosition: gapPosition)
                    .stroke(trailColor, style: strokeStyle)
                
                Group {
                    if let strokeColor = strokeColor {
                        switch strokeColor {
                        case let .solid(color):
                            Arc(gapDegree: gapDegree, gapPosition: gapPosition)
                                .trim(from: 0, to: progress)
                                .stroke(color, style: strokeStyle)
                        case let .gradient(end, start):
                            LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing)
                                .mask {
                                    Arc(gapDegree: gapDegree, gapPosition: gapPosition)
                                        .trim(from: 0, to: progress)
                                        .stroke(.white, style: strokeStyle)
                                }
                        }
                    } else {
                        Arc(gapDegree: gapDegree, gapPosition: gapPosition)
                            .trim(from: 0, to: progress)
                            .stroke(progressColor(progress: progress), style: strokeStyle)
                    }
                }
                .animation(.linear(duration: 0.3), value: progress)
            }
            .rotationEffect(.degrees(-90))
            .frame(width: size.circle - strokeWidth, height: size.circle - strokeWidth)

            if showInfo {
                Group {
                    if let currentValueLabel = configuration.currentValueLabel {
                        currentValueLabel
                    } else if status == .exception {
                        IconView(icon: .outlined(.close), size: size.icon)
                    } else if isSuccess(progress: progress) {
                        IconView(icon: .outlined(.check), size: size.icon)
                    } else {
                        Text(progress.formatted(.percent))
                    }
                }
                .font(.system(size: size.font))
                .foregroundColor(textColor(progress: progress))
            }
        }
        .padding(strokeWidth / 2)
    }
}

fileprivate extension ProgressSize {
    var circle: CGFloat {
        switch self {
        case .default:
            return 120
        case .small:
            return 80
        }
    }
    
    var font: CGFloat {
        circle * 0.15 + 6
    }
    
    var icon: CGSize {
        switch self {
        case .default:
            return .init(width: 28, height: 28)
        case .small:
            return .init(width: 21, height: 21)
        }
    }
}
