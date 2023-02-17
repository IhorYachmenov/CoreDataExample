//
//  UIButton.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import UIKit

extension UIButton {
    func playerButtonState(isPlaying: Bool) {
        if (isPlaying) {
            self.configuration?.title = Constants.SingerTrackDetailsScreen.pauseButtonTitle
            self.configuration?.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.playButtonPauseImgName)
        } else {
            self.configuration?.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.playButtonDefaultImgName)
            self.configuration?.title = Constants.SingerTrackDetailsScreen.playButtonTitle
        }
    }
    
    // Code below for testing
    private struct AssociatedKeys {
        static var show: Bool = true
    }
    
    var showLoader: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.show) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.show, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    //    objc_getAssociatedObject is a function in Objective-C runtime that allows you to get the value of an associated object that is attached to an object at runtime. It's commonly used to add properties to an object without subclassing it or modifying its implementation directly.
    //
    //    In other words, objc_getAssociatedObject allows you to add custom properties to an object at runtime, without changing its class definition. It does this by associating a key-value pair with the object, where the key is a pointer to a static variable and the value is the custom property.
    //
    //    You can use objc_setAssociatedObject to associate an object with another object, and objc_removeAssociatedObjects to remove the association.
    
    //    OBJC_ASSOCIATION_RETAIN_NONATOMIC is a constant that is used as a value for the objc_AssociationPolicy enumeration in Objective-C runtime. It indicates how to manage the memory of an associated object when it is set using the objc_setAssociatedObject function.
    //
    //    In particular, OBJC_ASSOCIATION_RETAIN_NONATOMIC specifies that the associated object should be retained by the runtime using strong reference semantics, but not use atomic accessors. This means that the memory management for the associated object will not be thread-safe, but it can be faster than using atomic accessors.
    //
    //    For example, if you set an associated object with OBJC_ASSOCIATION_RETAIN_NONATOMIC and the object is deallocated, the associated object will not be automatically released, which could result in a memory leak. It is up to the developer to manage the memory of the associated object in this case.
}
