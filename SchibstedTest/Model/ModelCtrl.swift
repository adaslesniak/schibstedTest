// DataCtrl.swift [SchibstedTest] created by: Adas Lesniak on: 01/04/2019 
// Copyright ©Aulendil   All rights reserved.

import Foundation

//every UI piece should access data trough this single gateway, what's not defined trough this is not part of application. ViewControllers are to controll views, not data or  we are in god's class teritory
//nothing accessed through this can't have any coupling with any UI pice. Use even't driven pattern. If it is updated then crete "update" event, don't call directly any UI view controllers
//TODO: move that to separate subproject so things exposed for other data pieces of data are not exposed to UI pieces, like for example comunication with backend can/should be totally encapsulated away from UI code
public class ModelCtrl  {
    
    public static let content = ContentList()
}
