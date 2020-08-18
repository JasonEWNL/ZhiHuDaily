//
//  TopStoryWidget.swift
//  TopStoryWidgetExtension
//
//  Created by JasonEWNL on 8/9/20.
//

import SwiftUI
import WidgetKit

@main
struct TopStoryWidget: Widget {
    private let kind: String = "TopStoryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TopStoryProvider()) { entry in
            TopStoryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(Localizable.topStoriesWidget.rawValue)
        .description(Localizable.topStoriesWidgetDescription.rawValue)
    }
}

let topStoryPairs = [
    (TopStory(title: "35 岁真的就很容易失业吗？", hint: "作者 / Sean Ye"), Image("9726467")),
    (TopStory(title: "在赤道上的时钟会比在极点慢吗？", hint: "作者 / 知乎用户"), Image("9726491")),
    (TopStory(title: "猫以高难度的姿势睡觉真的舒服吗？（多图）", hint: "作者 / 猫研所"), Image("9726399")),
    (TopStory(title: "上海博物馆那么多青铜器从哪来的？", hint: "作者 / 信古斋主人"), Image("9726393"))
]

struct TopStoryWidget_Previews: PreviewProvider {
    static let entry = TopStoryEntry(date: Date(), topStoryPairs: topStoryPairs)
    
    static var previews: some View {
        Group {
            TopStorySmallWidgetEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
        Group {
            TopStoryMediumWidgetEntryView(entry: entry)
            
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                TopStoryMediumWidgetEntryView(entry: entry)
                    .environment(\.colorScheme, .dark)
            }
        }
        .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        Group {
            TopStoryLargeWidgetEntryView(entry: entry)
            
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                TopStoryLargeWidgetEntryView(entry: entry)
                    .environment(\.colorScheme, .dark)
            }
        }
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
