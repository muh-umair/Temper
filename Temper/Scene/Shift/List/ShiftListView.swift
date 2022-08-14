//
//  ShiftListView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI
import Services

/// Scene for shifts list
struct ShiftListView: View {
    // MARK: - Properties
    @StateObject var viewModel: ShiftListViewViewModel
    
    // MARK: - View
    private var verticalSeparator: some View {
        Rectangle()
            .fill(.black)
            .frame(width: 0.5)
            .padding([.vertical], 6)
    }
    
    private var buttonsOverlay: some View {
        HStack {
            ImageButton(
                viewModel: viewModel.filtersButtonVM
            )
                .padding([.leading], Config.buttonsOverlayHorizontalPadding)
                .accessibility(identifier: AccessibilityIdentifier.filtersButton)
            
            verticalSeparator
            
            ImageButton(
                viewModel: viewModel.mapButtonVM
            )
                .padding([.trailing], Config.buttonsOverlayHorizontalPadding)
                .accessibility(identifier: AccessibilityIdentifier.mapButton)
        }
        .frame(height: Config.buttonsOverlayHeight)
        .background(Color.white)
        .cornerRadius(Config.buttonsOverlayCornerRadius)
        .shadow(radius: Config.buttonsOverlayShadowRadius)
        .padding([.bottom], Config.buttonsOverlayBottomPadding)
    }
    
    private var list: some View {
        List {
            ForEach(viewModel.shifts) { section in
                Section {
                    ForEach(section.shifts) { shiftVM in
                        ShiftRowView(viewModel: shiftVM)
                            .listRowSeparator(.hidden)
                            .onAppear {
                                viewModel.loadShiftsDataIfRequired(shiftVM)
                            }
                    }
                } header: {
                    SectionHeader(viewModel: section.header)
                }
                .textCase(nil)
            }
            if viewModel.isLoadingShifts {
                HStack(alignment: .center) {
                    ProgressView(L10n.loading.localized)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
        .refreshable {
            viewModel.refreshShiftsData()
        }
        .listStyle(.inset)
    }
    
    var footer: some View {
        HStack(alignment: .top, spacing: Config.authButtonsSpacing) {
            PrimaryButton(
                viewModel: viewModel.signUpButtonVM
            )
                .accessibility(identifier: AccessibilityIdentifier.signupButton)
            
            InvertedButton(
                viewModel: viewModel.loginButtonVM
            )
                .accessibility(identifier: AccessibilityIdentifier.loginButton)
        }
        .padding()
        .shadow(radius: Config.footerShadowRadius)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                list
                buttonsOverlay
            }
            footer
        }
        .padding([.top], Config.contentTopPadding)
        .clipped()
    }
}

// MARK: View Config
private extension ShiftListView {
    struct Config {
        static let buttonsOverlayHorizontalPadding: CGFloat = 4
        static let buttonsOverlayHeight: CGFloat = 48
        static let buttonsOverlayCornerRadius: CGFloat = 48
        static let buttonsOverlayShadowRadius: CGFloat = 4
        static let buttonsOverlayBottomPadding: CGFloat = 36
        static let authButtonsSpacing: CGFloat = 16
        static let footerShadowRadius: CGFloat = 4
        static let contentTopPadding: CGFloat = 8
    }
}


// MARK: - Accessibility
private extension ShiftListView {
    struct AccessibilityIdentifier {
        static let filtersButton: String = "ShiftsList.FiltersButton"
        static let mapButton: String = "ShiftsList.MapButton"
        static let loginButton: String = "ShiftsList.LoginButton"
        static let signupButton: String = "ShiftsList.SignupButton"
    }
}

// MARK: - Preview
struct ShiftListView_Previews: PreviewProvider {
    private static var mockShiftsRepository: ShiftRepositoryProtocol {
        let repository = MockShiftRepository()
        repository.shifts = [mockShift]
        return repository
    }
    
    static var previews: some View {
        ShiftListView(
            viewModel: .init(
                shiftsRepository: mockShiftsRepository
            )
        )
    }
}

