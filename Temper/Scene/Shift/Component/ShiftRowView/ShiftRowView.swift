//
//  ShiftRowView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// View for shift row in the list
struct ShiftRowView: View {
    // MARK: - Properties
    @StateObject var viewModel: ShiftRowViewViewModel
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                
                GeometryReader { geometry in
                    AsyncImage(url: viewModel.imageURL) { image in
                        image.resizable()
                             .frame(width: geometry.size.width, height: geometry.size.height)
                             .aspectRatio(contentMode: .fill)
                             .cornerRadius(Config.cornerRadius)
                    } placeholder: {
                        HStack(alignment: .center) {
                            ProgressView()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                VStack {
                    Text(viewModel.earnings)
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(Config.earningsPadding)
                }
                .background(Color.white)
                .cornerRadius(Config.cornerRadius)
                .offset(x: Config.earningsOffset, y: Config.earningsOffset)
            }
            .frame(height: Config.imageHeight)
            
            VStack(alignment: .leading, spacing: Config.descriptionsSpacing) {
                Text(viewModel.categoryAndDistance)
                    .foregroundColor(.appPurple)
                    .font(.callout)
                    .fontWeight(.bold)
                
                Text(viewModel.clientName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(viewModel.time)
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(.black)
            }
            .padding([.top], Config.descriptionsTopPadding)
        }
        .padding([.vertical], Config.contentVerticalPadding)
    }
}

// MARK: - View Config
private extension ShiftRowView {
    struct Config {
        static let cornerRadius: CGFloat = 10
        static let earningsPadding: EdgeInsets = EdgeInsets(
            top: 8,
            leading: 16,
            bottom: 18,
            trailing: 26
        )
        static let earningsOffset: CGFloat = 10
        static let imageHeight: CGFloat = 225
        static let descriptionsSpacing: CGFloat = 4
        static let descriptionsTopPadding: CGFloat = 8
        static let contentVerticalPadding: CGFloat = 4
    }
}

//// MARK: - Preview
struct ShiftRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftRowView(
            viewModel: .init(
                shift: mockShift,
                locationProvider: nil
            )
        ).previewLayout(.fixed(width: 350, height: 305))
    }
}

