//
//  TopStoryEntry.swift
//  TopStoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI
import WidgetKit

struct TopStoryEntry: TimelineEntry {
    let date: Date
    let topStoryPairs: [(TopStory, Image)]
}
