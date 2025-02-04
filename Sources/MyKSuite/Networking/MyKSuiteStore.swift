//
//  UserProfileStore.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 30/01/2025.
//

import Foundation
import InfomaniakCore
import InfomaniakDI
import OSLog

@available(iOS 14.0, *)
public actor MyKSuiteStore {
    public typealias UserId = Int

    let preferencesURL: URL
    let storeFileURL: URL

    var kSuites: [UserId: MyKSuite]?

    public init() {
        @InjectService var appGroupPathProvider: AppGroupPathProvidable
        preferencesURL = appGroupPathProvider.groupDirectoryURL.appendingPathComponent(
            "preferences/",
            isDirectory: true
        )
        storeFileURL = preferencesURL.appendingPathComponent("myKSuites.json")
    }

    @discardableResult
    public func updateMyKSuite(with apiFetcher: ApiFetcher) async throws -> MyKSuite {
        await loadIfNeeded()
        let myKSuite = try await apiFetcher.myKSuite()
        kSuites?[myKSuite.id] = myKSuite

        await save()

        return myKSuite
    }

    public func getMyKSuite(id: UserId) async -> MyKSuite? {
        await loadIfNeeded()
        return kSuites?[id]
    }

    public func removeMyKSuite(id: UserId) async {
        kSuites?.removeValue(forKey: id)
        await save()
    }

    private func save() async {
        let encoder = JSONEncoder()
        do {
            let kSuitesData = try encoder.encode(kSuites)
            try FileManager.default.createDirectory(atPath: preferencesURL.path, withIntermediateDirectories: true)
            try kSuitesData.write(to: storeFileURL)
        } catch {
            Logger.general.error("[MyKSuiteStore] Error saving accounts :\(error)")
        }
    }

    private func loadIfNeeded() async {
        guard kSuites == nil else {
            return
        }

        kSuites = [:]

        let decoder = JSONDecoder()

        do {
            let data = try Data(contentsOf: storeFileURL)
            let savedKSuites = try decoder.decode([UserId: MyKSuite].self, from: data)

            kSuites = savedKSuites
        } catch {
            Logger.general.error("[MyKSuiteStore] Error loading accounts :\(error)")
        }
    }
}
