//
//  TopStoryWidgetEntryView.swift
//  TopStoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI

struct TopStoryWidgetEntryView: View {
    let entry: TopStoryEntry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            TopStorySmallWidgetEntryView(entry: entry)
        case .systemMedium:
            TopStoryMediumWidgetEntryView(entry: entry)
        case .systemLarge:
            TopStoryLargeWidgetEntryView(entry: entry)
        @unknown default:
            TopStorySmallWidgetEntryView(entry: entry)
        }
    }
}
