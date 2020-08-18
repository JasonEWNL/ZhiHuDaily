//
//  StoryWidgetEntryView.swift
//  StoryWidgetExtension
//
//  Created by TwTStudio on 8/17/20.
//

import SwiftUI

struct StoryWidgetEntryView: View {
    let entry: StoryEntry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            StorySmallWidgetEntryView(entry: entry)
        case .systemMedium:
            StoryMediumWidgetEntryView(entry: entry)
        case .systemLarge:
            StoryLargeWidgetEntryView(entry: entry)
        @unknown default:
            StorySmallWidgetEntryView(entry: entry)
        }
    }
}
