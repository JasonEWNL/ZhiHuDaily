//
//  StoryWidget.swift
//  StoryWidget
//
//  Created by TwTStudio on 8/17/20.
//

import SwiftUI
import WidgetKit
import Intents

@main
struct StoryWidget: Widget {
    private let kind: String = "StoryWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: StoryIntent.self, provider: StoryProvider()) { entry in
            StoryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(Localizable.storiesWidget.rawValue)
        .description(Localizable.storiesWidgetDescription.rawValue)
    }
}

let storyPairs = [
    (Story(title: "35 岁真的就很容易失业吗？", hint: "作者 / Sean Ye"), Image("9726467")),
    (Story(title: "在赤道上的时钟会比在极点慢吗？", hint: "作者 / 知乎用户"), Image("9726491")),
    (Story(title: "猫以高难度的姿势睡觉真的舒服吗？（多图）", hint: "作者 / 猫研所"), Image("9726399")),
    (Story(title: "上海博物馆那么多青铜器从哪来的？", hint: "作者 / 信古斋主人"), Image("9726393"))
]

struct StoryWidget_Previews: PreviewProvider {
    static let entry = StoryEntry(date: Date(), storyPairs: storyPairs)
    
    static var previews: some View {
        Group {
            StorySmallWidgetEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
        Group {
            StoryMediumWidgetEntryView(entry: entry)
            
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                StoryMediumWidgetEntryView(entry: entry)
                    .environment(\.colorScheme, .dark)
            }
        }
        .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        Group {
            StoryLargeWidgetEntryView(entry: entry)
            
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                StoryLargeWidgetEntryView(entry: entry)
                    .environment(\.colorScheme, .dark)
            }
        }
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
