//
//  StoryEntry.swift
//  StoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI
import WidgetKit

struct StoryEntry: TimelineEntry {
    let date: Date
    let storyPairs: [(TopStory, Image)]
}
