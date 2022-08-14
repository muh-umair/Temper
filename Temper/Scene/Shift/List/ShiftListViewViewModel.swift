//
//  ShiftListViewViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation
import Services

/// Datastructure to define list section
struct ShiftListSection: Identifiable {
    /// Identifier for section
    var id: String { header.text }
    
    /// Header ViewModel for the section
    let header: SectionHeaderViewModel
    
    /// Shift ViewModel for the list
    private(set) var shifts: [ShiftRowViewViewModel]
    
    /// Append new shifts to the section
    mutating func append(shifts: [ShiftRowViewViewModel]) {
        self.shifts.append(contentsOf: shifts)
    }
}

/// ViewModel for `ShiftListView`
final class ShiftListViewViewModel: ObservableObject {
    // MARK: - Published properties
    /// List sections
    @Published private(set) var shifts: [ShiftListSection] = []
    
    /// Loading state
    @Published private(set) var isLoadingShifts = false
    
    /// Error message
    @Published var errorMessage: String?
    
    // MARK: - Private properties
    private unowned let coordinator: MainCoordinator?
    private let shiftsRepository: ShiftRepositoryProtocol
    private var fetchShiftsRequest: FetchShiftsRequest
    private let locationProvider: LocationProviderProtocol?
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        return formatter
    }()
    
    /// Initializer
    ///
    /// - parameter shiftsRepository: `ShiftRepositoryProtocol` that provide all actions on shift e.g. fetch.
    /// - parameter coordinator: `MainCoordinator` to handle navigation.
    /// - parameter locationProvider: `LocationProviderProtocol` to get user's current location for distance calculation.
    init(
        shiftsRepository: ShiftRepositoryProtocol,
        coordinator: MainCoordinator? = nil,
        locationProvider: LocationProviderProtocol? = nil
    ) {
        self.shiftsRepository = shiftsRepository
        self.coordinator = coordinator
        self.locationProvider = locationProvider
        // Start with current date
        self.fetchShiftsRequest = FetchShiftsRequest(date: Date())
        
        // Load initial data
        Task {
            await fetchShifts()
        }
    }
    
    /// Refresh shifts list data i.e. remove old data and fetch new data for current date.
    func refreshShiftsData() {
        resetShifts()
        Task {
            await fetchShifts()
        }
    }
    
    /// Decide if we have reached almost at end of last section then load shifts for the next day.
    func loadShiftsDataIfRequired(_ shiftVM: ShiftRowViewViewModel) {
        if shouldFetchNextShifts(shiftId: shiftVM.id, startsAt: shiftVM.startsAt) {
            Task {
                await fetchShifts()
            }
        }
    }
    
    /// Retry to fetch shifts from repository.
    func retryLoadShifts() {
        Task {
            await fetchShifts()
        }
    }
}

// MARK: - Computed properties
extension ShiftListViewViewModel {
    /// ViewModel for sign up button
    var signUpButtonVM: PrimaryButtonViewModel {
        .init(title: L10n.shift_list_signup_button.localized) { [weak self] in
            self?.coordinator?.openSignup()
        }
    }
    
    /// ViewModel for login button
    var loginButtonVM: InvertedButtonViewModel {
        .init(title: L10n.shift_list_login_button.localized) { [weak self] in
            self?.coordinator?.openLogin()
        }
    }
    
    /// ViewModel for filters button
    var filtersButtonVM: ImageButtonViewModel {
        .init(title: L10n.shift_list_filters_button.localized, imageName: "ic_filter") {  [weak self] in
            self?.coordinator?.openFilters()
        }
    }
    
    /// ViewModel for map button
    var mapButtonVM: ImageButtonViewModel {
        .init(title: L10n.shift_list_map_button.localized, imageName: "ic_location") {  [weak self] in
            self?.coordinator?.openMap()
        }
    }
}


// MARK: - Shifts list data handling
extension ShiftListViewViewModel {
    /// Reset fetch request to current date and remove old data.
    func resetShifts() {
        fetchShiftsRequest = FetchShiftsRequest(date: Date())
        DispatchQueue.main.async {
            self.shifts.removeAll()
        }
    }
    
    /// Fetch shifts from the repository and append them in the list. Also, moves the request to next date for next fetch requests.
    func fetchShifts() async {
        guard !isLoadingShifts else {
            return
        }
        DispatchQueue.main.async {
            self.isLoadingShifts = true
        }
        do {
            let response = try await shiftsRepository.fetchShifts(fetchShiftsRequest)
            DispatchQueue.main.async {
                self.append(shifts: response.shifts)
                self.fetchShiftsRequest = FetchShiftsRequest(
                    date: self.fetchShiftsRequest.date.add(.day, 1) ?? self.fetchShiftsRequest.date
                )
                self.errorMessage = nil
                self.isLoadingShifts = false
            }
        } catch let error {
            DispatchQueue.main.async {
                self.errorMessage = (error as? NetworkError)?.errorDescription
                self.isLoadingShifts = false
            }
        }
    }
    
    /// Append shifts to the list data.
    func append(shifts newShifts: [Shift]) {
        guard let section = sectionHeader(from: newShifts.first?.startsAt) else {
            return
        }
        let shiftVMS = newShifts.map { shift in
            ShiftRowViewViewModel(shift: shift, locationProvider: locationProvider)
        }.sorted { lhs, rhs in
            lhs.startsAt.compare(rhs.startsAt) == .orderedAscending
        }
        if let idx = self.shifts.firstIndex(where: { $0.header.text == section }) {
            self.shifts[idx].append(shifts: shiftVMS)
        } else {
            self.shifts.append(
                ShiftListSection(
                    header: .init(text: section),
                    shifts: shiftVMS
                )
            )
        }
    }
    
    /// Create text for the section header.
    func sectionHeader(from date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        return dateFormatter.string(from: date)
    }
    
    /// Check if the shift is almost at the end of last section.
    ///
    /// - parameter shiftId: `id` of the shift
    /// - parameter startsAt: Start time of the date
    /// - returns: `true` if should load next shifts data; otherwise `false`
    func shouldFetchNextShifts(shiftId: String, startsAt: Date) -> Bool {
        guard let section = sectionHeader(from: startsAt),
              let sectionIdx = shifts.firstIndex(where: { $0.header.text == section })
        else {
            return false
        }
        let shifts = shifts[sectionIdx].shifts
        guard let shiftIdx = shifts.firstIndex(where: { $0.id == shiftId })
        else {
            return false
        }
        let thresholdIdx = shifts.index(shifts.endIndex, offsetBy: -5)
        
        return sectionIdx == shifts.count - 1 && shiftIdx == thresholdIdx
    }
}
