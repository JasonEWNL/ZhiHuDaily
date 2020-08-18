//
//  StoryEntry.swift
//  StoryWidgetExtension
//
//  Created by TwTStudio on 8/17/20.
//

import SwiftUI
import WidgetKit

struct StoryEntry: TimelineEntry {
    let date: Date
    let storyPairs: [(Story, Image)]
}
