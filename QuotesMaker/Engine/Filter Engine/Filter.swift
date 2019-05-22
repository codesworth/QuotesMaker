//
//  Filter.swift
//  QuotesMaker
//
//  Created by Shadrach Mensah on 15/05/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

struct Filters {
    
    public static var availableFilters = availableColorFilters.merge(availableColorAdjustmentFilters).merge(availableStylyzedFilters)

    private static let allColorFilters = ["CIColorCrossPolynomial", "CIColorCube", "CIColorCubesMixedWithMask", "CIColorCubeWithColorSpace", "CIColorCurves", "CIColorInvert", "*CIColorMap", "CIColorMonochrome", "CIColorPosterize", "CIDither", "CIFalseColor", "*CILabDeltaE", "CIMaskToAlpha", "*CIMaximumComponent", "CIMinimumComponent", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone", "CIThermal", "CIVignette", "*CIVignetteEffect", "CIXRay"]
    
    private static let availableColorFilters = [ "CIColorCurves", "CIColorInvert", "CIColorMonochrome", "CIColorPosterize", "CIDither", "CIFalseColor", "CIMaskToAlpha", "CIMaximumComponent", "CIMinimumComponent", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone", "CIThermal", "CIVignette", "CIXRay"]
    
    private static let availableColorAdjustmentFilters = ["CIColorMatrix","CIHueAdjust", "CILinearToSRGBToneCurve", "CISRGBToneCurveToLinear", "CITemperatureAndTint", "CIToneCurve", "CIVibrance"]
    private static let allColorAdjustmentFilters = ["CIColorClamp", "CIColorControls", "CIColorMatrix", "CIColorPolynomial", "CIDepthToDisparity", "CIDisparityToDepth", "CIExposureAdjust", "CIGammaAdjust", "CIHueAdjust", "CILinearToSRGBToneCurve", "CISRGBToneCurveToLinear", "CITemperatureAndTint", "CIToneCurve", "CIVibrance", "CIWhitePointAdjust"]
    
    private let allSharpenFilters = ["CISharpenLuminance", "CIUnsharpMask"]
    
    private let allHalfToneEffects = ["CICircularScreen", "CICMYKHalftone", "CIDotScreen", "CIHatchedScreen", "CILineScreen"]
    
    private let allReductionFilters = ["CIAreaAverage", "CIAreaHistogram", "CIAreaMaximum", "CIAreaMaximumAlpha", "CIAreaMinimum", "CIAreaMinimumAlpha", "CIColumnAverage", "CIHistogramDisplayFilter", "CIRowAverage"]
    
    private let allStylizedFilters = ["CIBlendWithAlphaMask", "CIBlendWithMask", "CIBloom", "CIComicEffect", "CIConvolution3X3", "CIConvolution5X5", "CIConvolution7X7", "CIConvolution9Horizontal", "CIConvolution9Vertical", "CICrystallize", "CIDepthOfField", "CIEdges", "CIEdgeWork", "CIGloom", "CIHeightFieldFromMask", "CIHexagonalPixellate", "CIHighlightShadowAdjust", "CILineOverlay", "CIPixellate", "CIPointillize", "CIShadedMaterial", "CISpotColor", "CISpotLight"]
    
    private static let availableStylyzedFilters = ["CIComicEffect",  "CICrystallize", "CIEdgeWork", "CIPointillize", "CISpotColor"]
    private let allTransitionFilters = ["CIAccordionFoldTransition", "CIBarsSwipeTransition", "CICopyMachineTransition", "CIDisintegrateWithMaskTransition", "CIDissolveTransition", "CIFlashTransition", "CIModTransition", "CIPageCurlTransition", "CIPageCurlWithShadowTransition", "CIRippleTransition", "CISwipeTransition"]
}

