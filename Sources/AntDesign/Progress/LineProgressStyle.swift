//
//  LineProgressStyle.swift
//  
//
//  Created by François Boulais on 13/07/2022.
//

import SwiftUI

public struct ProgressSuccess {
    let percent: CGFloat
    let color: Color
    
    public init(percent: CGFloat, color: Color = Preferences.successColor) {
        self.percent = percent
        self.color = color
    }
}

public enum ProgressStatus {
    case success
    case exception
    case normal
    case active
}

public enum ProgressColor {
    case solid(Color)
    case gradient(start: Color, end: Color)
}

public struct LineProgressStyle: ProgressViewStyle {
    public enum Size {
        case small
        case `default`
        
        var height: CGFloat {
            switch self {
            case .default:
                return 8
            case .small:
                return 6
            }
        }
        
        var font: CGFloat {
            switch self {
            case .default:
                return Preferences.fontSizeBase
            case .small:
                return Preferences.fontSizeSm
            }
        }
        
        var icon: CGSize {
            switch self {
            case .default:
                return .init(width: 16, height: 16)
            case .small:
                return .init(width: 14, height: 14)
            }
        }
    }
    
    private struct Line: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: .init(x: rect.minX, y: rect.midY))
            path.addLine(to: .init(x: rect.maxX, y: rect.midY))
            return path
        }
    }
    
    let size: Size
    let showInfo: Bool
    let status: ProgressStatus
    let strokeColor: ProgressColor?
    let strokeLinecap: CGLineCap
    let success: ProgressSuccess?
    let trailColor: Color
        
    private var strokeStyle: StrokeStyle {
        .init(lineWidth: size.height, lineCap: strokeLinecap)
    }
    
    public init(
        size: Size = .default,
        status: ProgressStatus = .normal,
        strokeLinecap: CGLineCap = .round,
        showInfo: Bool = true,
        trailColor: Color = Preferences.progressRemainingColor,
        strokeColor: ProgressColor? = nil,
        success: ProgressSuccess? = nil
    ) {
        self.size = size
        self.status = status
        self.strokeLinecap = strokeLinecap
        self.showInfo = showInfo
        self.trailColor = trailColor
        self.strokeColor = strokeColor
        self.success = success
    }
    
    private func progressColor(progress: CGFloat) -> Color {
        switch status {
        case .success:
            return Preferences.successColor
        case .exception:
            return Preferences.errorColor
        case .active:
            return Preferences.progressDefaultColor
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
        case .active:
            return Preferences.progressTextColor
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
        
        HStack(spacing: Preferences.paddingSm) {
            ZStack(alignment: .leading) {
                GeometryReader { proxy in
                    Line()
                        .stroke(trailColor, style: strokeStyle)

                    Group {
                        if let strokeColor = strokeColor {
                            switch strokeColor {
                            case .solid(let color):
                                Line()
                                    .stroke(color, style: strokeStyle)
                                    .frame(width: proxy.size.width * progress)
                            case .gradient(let start, let end):
                                LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing)
                                    .mask(Line().stroke(.white, style: strokeStyle))
                                    .frame(width: proxy.size.width * progress)
                            }
                        } else {
                            Line()
                                .stroke(progressColor(progress: progress), style: strokeStyle)
                                .frame(width: proxy.size.width * progress)
                        }
                    }
                    .animation(.linear(duration: 0.3), value: progress)
                    .overlay {
                        if status == .active {
                            ActiveView(style: strokeStyle)
                        }
                    }
                    
                    if let success = success {
                        Line()
                            .stroke(success.color, style: strokeStyle)
                            .frame(width: proxy.size.width * success.percent)
                    }
                }
            }
            
            if showInfo {
                Group {
                    if let currentValueLabel = configuration.currentValueLabel {
                        currentValueLabel
                    } else {
                        HStack {
                            if status == .exception {
                                IconView(icon: .filled(.closeCircle), size: size.icon)
                            } else if isSuccess(progress: progress) {
                                IconView(icon: .filled(.checkCircle), size: size.icon)
                            } else {
                                Text(progress.formatted(.percent))
                            }
                            
                            Spacer(minLength: 0)
                        }
                    }
                }
                .font(.system(size: size.font))
                .foregroundColor(textColor(progress: progress))
                .frame(height: size.font)
                .frame(minWidth: 2 * size.font + 8)
                .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
    
    struct ActiveView: View {
        @State private var progress: CGFloat = 0
                
        let duration: TimeInterval = 2.4
        let style: StrokeStyle
        
        var body: some View {
            GeometryReader { proxy in
                Line()
                    .stroke(Preferences.componentBackground, style: style)
                    .opacity(progress == 0 ? 0.5 : 0.0)
                    .frame(width: progress == 0 ? 0 : proxy.size.width)
                    .offset(x: progress == 0 ? -proxy.size.width : 0)
                    .animation(
                        .easeOut(duration: duration * 0.8)
                        .delay(duration * 0.2)
                        .repeatForever(autoreverses: false),
                        value: progress
                    )
                    .onAppear {
                        progress = 1
                    }
            }
        }
    }
}
