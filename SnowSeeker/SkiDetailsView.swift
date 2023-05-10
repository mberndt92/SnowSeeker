//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Maximilian Berndt on 2023/05/09.
//

import SwiftUI

struct SkiDetailsView: View {
    
    let resort: Resort
    
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
            }
            
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)m")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SkiDetailsView(resort: Resort.example)
        }
    }
}
