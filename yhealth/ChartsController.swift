//
//  ChartsController.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/13/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import SwiftCharts
import CoreGraphics

class ChartsController: UIViewController {
    
    @IBOutlet weak var nasdaqView: UIView!
    @IBOutlet weak var vitechView: UIView!

    
    
    fileprivate var chart: Chart?
    
    fileprivate let colorBarHeight: CGFloat = 50
    
    fileprivate let useViewsLayer = true
    
    
    func chartFrame(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 70, width: containerBounds.size.width, height: containerBounds.size.height - 70)
    }
    
    
    var labelFont: UIFont {
        return self.fontWithSize(11)
    }
    
    
    func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    
    var iPhoneChartSettings: ChartSettings {
        let chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        return chartSettings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.chartFrame(self.nasdaqView.bounds)
        let chartFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - colorBarHeight)
        let colorBar = ColorBar(frame: CGRect(x: 0, y: chartFrame.origin.y + chartFrame.size.height, width: self.view.frame.size.width, height: self.colorBarHeight), c1: UIColor.red, c2: UIColor.green)
        self.view.addSubview(colorBar)
        
        
        let labelSettings = ChartLabelSettings(font: self.labelFont)
        
        func toColor(_ percentage: Double) -> UIColor {
            return colorBar.colorForPercentage(percentage).withAlphaComponent(0.6)
        }
        
        let rawData: [(Double, Double, Double, UIColor)] = [
            (2, 2, 100, toColor(0)),
            (2.1, 5, 250, toColor(0)),
            (4, 4, 200, toColor(0.2)),
            (2.3, 5, 150, toColor(0.7)),
            (11, 4, 200, toColor(0.5)),
            (11.5, 10, 150, toColor(0.7)),
            (12, 7, 120, toColor(0.9)),
            (12, 9, 250, toColor(0.8))
        ]
        
        let chartPoints: [ChartPointBubble] = rawData.map{ChartPointBubble(x: ChartAxisValueDouble($0, labelSettings: labelSettings), y: ChartAxisValueDouble($1), diameterScalar: $2, bgColor: $3)}
        
        let xValues = stride(from: (-2), through: 14, by: 2).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
        let yValues = stride(from: (-2), through: 12, by: 2).map {ChartAxisValueInt($0, labelSettings: labelSettings)}
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Insurance Companies", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Claims", settings: labelSettings.defaultVertical()))
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: self.iPhoneChartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let bubbleLayer = self.bubblesLayer(xAxis: xAxis, yAxis: yAxis, chartInnerFrame: innerFrame, chartPoints: chartPoints)
        
        let guidelinesLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: 0.1)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: guidelinesLayerSettings)
        
        let guidelinesHighlightLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.red, linesWidth: 1, dotWidth: 4, dotSpacing: 4)
        let guidelinesHighlightLayer = ChartGuideLinesForValuesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: guidelinesHighlightLayerSettings, axisValuesX: [ChartAxisValueDouble(0)], axisValuesY: [ChartAxisValueDouble(0)])
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                guidelinesHighlightLayer,
                bubbleLayer
            ]
        )
        
        self.nasdaqView.addSubview(chart.view)
        self.chart = chart
    
    // VITECH BAR CHART
    
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        let barFrame = self.chartFrame(self.nasdaqView.bounds)

        let barChart = BarsChart(
            frame: CGRect(x: barFrame.origin.x, y: barFrame.origin.y, width: barFrame.size.width, height: barFrame.size.height - colorBarHeight),
            chartConfig: chartConfig,
            xTitle: "Insurance Companies",
            yTitle: "Y axis",
            bars: [
                ("ACME", 2),
                ("CIGNA", 3),
                ("UNITED", 0.5)
            ],
            color: UIColor.red,
            barWidth: 20
        )
        
        
        self.vitechView.addSubview(barChart.view)

    }
    
    // We can use a view based layer for easy animation (or interactivity), in which case we use the default chart points layer with a generator to create bubble views.
    // On the other side, if we don't need animation or want a better performance, we use ChartPointsBubbleLayer, which instead of creating views, renders directly to the chart's context.
    fileprivate func bubblesLayer(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, chartInnerFrame: CGRect, chartPoints: [ChartPointBubble]) -> ChartLayer {
        
        let maxBubbleDiameter: Double = 30, minBubbleDiameter: Double = 2
        
        if self.useViewsLayer == true {
            
            let (minDiameterScalar, maxDiameterScalar): (Double, Double) = chartPoints.reduce((min: 0, max: 0)) {tuple, chartPoint in
                (min: min(tuple.min, chartPoint.diameterScalar), max: max(tuple.max, chartPoint.diameterScalar))
            }
            
            let diameterFactor = (maxBubbleDiameter - minBubbleDiameter) / (maxDiameterScalar - minDiameterScalar)
            
            return ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: chartInnerFrame, chartPoints: chartPoints, viewGenerator: {(chartPointModel, layer, chart) -> UIView? in
                
                let diameter = CGFloat(chartPointModel.chartPoint.diameterScalar * diameterFactor)
                
                let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: diameter)
                circleView.fillColor = chartPointModel.chartPoint.bgColor
                circleView.borderColor = UIColor.black.withAlphaComponent(0.6)
                circleView.borderWidth = 1
                circleView.animDelay = Float(chartPointModel.index) * 0.2
                circleView.animDuration = 1.2
                circleView.animDamping = 0.4
                circleView.animInitSpringVelocity = 0.5
                return circleView
            })
            
        } else {
            return ChartPointsBubbleLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: chartInnerFrame, chartPoints: chartPoints)
        }
    }
    
    class ColorBar: UIView {
        
        let dividers: [CGFloat]
        
        let gradientImg: UIImage
        
        lazy var imgData: UnsafePointer<UInt8> = {
            let provider = self.gradientImg.cgImage!.dataProvider
            let pixelData = provider!.data
            return CFDataGetBytePtr(pixelData)
        }()
        
        init(frame: CGRect, c1: UIColor, c2: UIColor) {
            
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: frame.width, height: 30)
            gradient.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.yellow.cgColor, UIColor.red.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            
            let imgHeight = 1
            let imgWidth = Int(gradient.bounds.size.width)
            
            let bitmapBytesPerRow = imgWidth * 4
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue).rawValue
            
            let context = CGContext (data: nil,
                                     width: imgWidth,
                                     height: imgHeight,
                                     bitsPerComponent: 8,
                                     bytesPerRow: bitmapBytesPerRow,
                                     space: colorSpace,
                                     bitmapInfo: bitmapInfo)
            
            UIGraphicsBeginImageContext(gradient.bounds.size)
            gradient.render(in: context!)
            
            let gradientImg = UIImage(cgImage: context!.makeImage()!)
            
            UIGraphicsEndImageContext()
            self.gradientImg = gradientImg
            
            let segmentSize = gradient.frame.size.width / 6
            self.dividers = Array(stride(from: segmentSize, through: gradient.frame.size.width, by: segmentSize))
            
            super.init(frame: frame)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 2
            

        }
        
        func colorForPercentage(_ percentage: Double) -> UIColor {
            
            let data = self.imgData
            
            let xNotRounded = self.gradientImg.size.width * CGFloat(percentage)
            let x = 4 * (floor(abs(xNotRounded / 4)))
            let pixelIndex = Int(x * 4)
            
            let color = UIColor(
                red: CGFloat(data[pixelIndex + 0]) / 255.0,
                green: CGFloat(data[pixelIndex + 1]) / 255.0,
                blue: CGFloat(data[pixelIndex + 2]) / 255.0,
                alpha: CGFloat(data[pixelIndex + 3]) / 255.0
            )
            return color
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    
}
