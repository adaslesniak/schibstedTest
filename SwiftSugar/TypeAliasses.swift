// GenericException.swift [SchibstedTest] created by: Adas Lesniak on: 01/04/2019 
// Copyright ©Aulendil   All rights reserved.

import Foundation


public enum Exception : Error { case error(String) }

public typealias Action = () -> Void
public typealias BoolAction = (Bool) -> Void

