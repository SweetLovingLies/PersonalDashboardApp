//
//  NavController.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//

import SwiftUI

final class NavController: ObservableObject {
	@Published var path = NavigationPath()
    
	// MARK: Methods
	
    /// adds a new destination to the navigation stack. Handles forward navigaiton.
    func navigate(to route: Route) {
//		print("Navigating to \(route)")
		
        path.append(route)
		
//		print(path)
    }
    /// Removes the current view from the Navigaiton stack. Handles backward navigation
    func navigateBack() {
        path.removeLast()
    }
    
    ///Clears the navigation stack. Returns to the home/root view. Handles complex navigation reset.
    func navigateToRoot() {
		path.removeLast(path.count)
    }
    
    /// Removes a specific number of views from the navigation stack. Enables custom back navigation handles partial stack clearing.
    func popToView(count: Int) {
        path.removeLast(count)
    }
}


extension NavController {
    func canNavigateBack() -> Bool {
        return path.count > 0
    }
}
