//
//  ZoomableUIView.swift
//  ZoomableUIView
//
//  Created by Coughlan, James on 06/07/2017.
//  Copyright © 2017 Coughlan, James. All rights reserved.
//

import UIKit

typealias EditorExpandableView = UIView & UIGestureRecognizerDelegate

public struct ZoomableViewOptions {
   var minZoom: CGFloat
   var maxZoom: CGFloat
   
   public init(minZoom: CGFloat, maxZoom: CGFloat) {
      self.minZoom = minZoom
      self.maxZoom = maxZoom
   }
}

public protocol ZoomableUIView {
   func reset()
   func viewForZooming() -> UIView
   func optionsForZooming() -> ZoomableViewOptions
   func willBeginZooming()
   func didEndZooming()
}

extension ZoomableUIView where Self:EditorExpandableView  {
   
    internal func reset() {
      UIView.animate(withDuration: 0.3) {
         self.viewForZooming().transform = .identity
        self.didEndZooming()
      }
      
      if let panGestureRecognizer = gestureRecognizers?.filter({$0 is UIPanGestureRecognizer}).first, let index = gestureRecognizers?.index(of: panGestureRecognizer) {
         gestureRecognizers?.remove(at: index)
      }
   }
   
    internal func setZoomable(_ zoomable: Bool) {
      viewForZooming().transform = .identity
      isUserInteractionEnabled = zoomable
      gestureRecognizers = nil
      layer.masksToBounds = zoomable
      
      if zoomable {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinchZoomableView(_:)))
         addGestureRecognizer(pinch)
         let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTappedZoomableView))
         tap.numberOfTapsRequired = 2
         addGestureRecognizer(tap)
        pinch.delegate = self
      }
   }
   
}

extension UIView:UIGestureRecognizerDelegate {
   
   @objc func didPinchZoomableView(_ pinch: UIPinchGestureRecognizer) {
    
      if let view = (self as? ZoomableUIView)?.viewForZooming(), let options = (self as? ZoomableUIView)?.optionsForZooming() {
        (self as? ZoomableUIView)?.willBeginZooming()
         switch pinch.state {
         case .ended:
            if view.transform.currentScale > options.minZoom && gestureRecognizers?.filter({$0 is UIPanGestureRecognizer}).count == 0 {
               let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanZoomableView(_:)))
               addGestureRecognizer(panGestureRecognizer)
                panGestureRecognizer.delegate = self
            } else if view.transform.currentScale <= options.minZoom  {
               (self as? ZoomableUIView)?.reset()
            }
         default:
            var pinchCentre = pinch.location(in: view)
            pinchCentre.x -= view.bounds.midX
            pinchCentre.y -= view.bounds.midY
            var newTransform = view.transform
            newTransform = newTransform.translatedBy(x: pinchCentre.x, y: pinchCentre.y)
            let scale = pinch.scale
            if (view.transform.currentScale + scale < options.maxZoom) {
               newTransform = newTransform.scaledBy(x: scale, y: scale)
               newTransform = newTransform.translatedBy(x: -pinchCentre.x, y: -pinchCentre.y)
               view.transform = newTransform
               pinch.scale = options.minZoom
            }
         }
      }
   }
   
   @objc func didPanZoomableView(_ pan: UIPanGestureRecognizer) {
      if let view = (self as? ZoomableUIView)?.viewForZooming() {
         let panTranslation = pan.translation(in: view)
         var newTransform = view.transform
         newTransform = newTransform.translatedBy(x: panTranslation.x, y: panTranslation.y)
         view.transform = newTransform
         pan.setTranslation(.zero, in: view)
      }
   }
   
   @objc func doubleTappedZoomableView() {
      (self as? ZoomableUIView)?.reset()
   }
   
}


