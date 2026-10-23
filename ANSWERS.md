# ANSWERS.md

**Name:** Khen Jay Angob
**Section:** ILFV3
**Student file name:** ILFV3_ANGOB_KHENJAY

## 1. GitHub repository
https://github.com/angobkhen-hub/flutter_basics_lab

## 2. Last three `build() called` lines (Activity 2)
```
build() called: 4 glasses
build() called: 5 glasses
build() called: 6 glasses
```

## 3. Experiment observations

**Activity 2: moved `_glasses++` outside `setState()`**
When I tapped +, nothing changed on the screen. The number stayed at "0 / 6 glasses" and the progress bar did not move, and no new `build() called` line appeared in the Debug Console. The value of `_glasses` was increasing in memory, but Flutter was never told to redraw. After a hot reload, `build()` ran again and the screen suddenly jumped to the real count. I put `_glasses++` back inside `setState()` afterward.

**Activity 3: removed `Expanded` from one StatBox**
Without `Expanded`, that box stopped sharing the row equally. It shrank to only the width of its own content (the icon, value and label), so it looked narrower than the other boxes, which still stretched to fill the remaining space. The row looked uneven. When the window was made narrow, the unequal widths made the layout cramped. I put `Expanded` back, and the boxes were equal again.

**Activity 5: changed the button corner radius from 8 to 20**
The Elevated button became much rounder, with pill-like corners. The Outlined and Filled buttons did not change, because `buildTheme()` only sets `elevatedButtonTheme`, which styles ElevatedButton widgets only.

## 4. Review questions

**1. What is the difference between a StatelessWidget and a StatefulWidget? Give one example of each from this lab.**
A StatelessWidget does not hold any data that changes after it is drawn. It only shows what it is given. An example is `ProfileCard` in Activity 1. A StatefulWidget holds data that can change while the app is running, and it redraws when that data changes. An example is `WaterTrackerPage` in Activity 2, which keeps the changing `_glasses` count.

**2. Why is a StatefulWidget written as two classes? What does each class do?**
The widget class (`WaterTrackerPage`) is only a configuration. Its only job is `createState()`, which creates the State object. The State class (`_WaterTrackerPageState`) keeps the data that changes (`_glasses`), the methods that update it, and the `build()` method that draws the screen. Splitting them lets Flutter recreate the widget cheaply while the State, and its data, stays alive.

**3. In Activity 2, what happened when you changed `_glasses` outside `setState()`? Why?**
The number on the screen did not update when I tapped +. The variable changed in memory, but `setState()` is what tells Flutter that the data changed and `build()` must run again. Without it, no rebuild happens, so the screen stays the same until something else (like a hot reload) triggers one.

**4. Looking at the Debug Console in Activity 2, when is `build()` called?**
`build()` is called once when the page first appears, and again every time `setState()` runs, which is after each tap on +, - or Reset. Each of those taps added a new `build() called` line in the Debug Console.

**5. Explain the main axis and the cross axis of a Row and of a Column.**
In a Row, the main axis runs horizontally (left to right) and the cross axis runs vertically. In a Column, the main axis runs vertically (top to bottom) and the cross axis runs horizontally. `mainAxisAlignment` positions children along the main axis, and `crossAxisAlignment` positions them along the cross axis.

**6. In Activity 3, what happened when you removed `Expanded` from a StatBox? What does `Expanded` do?**
The box shrank to the width of its content and the row became uneven. `Expanded` makes a child fill the free space along the main axis of a Row or Column. When several children are wrapped in `Expanded`, they share that space equally, so the three or four boxes stay the same width on any screen size.

**7. Why do we use `GridView.builder` for the menu instead of a Column with many children?**
`GridView.builder` creates only the cards that are visible on the screen, so it stays fast even with a long list. It also scrolls and arranges the items into columns automatically. A Column builds all its children at once, does not scroll by default, and can overflow when there are many items.

**8. How do `Stack` and `Positioned` create the Best seller badge in Activity 4?**
A `Stack` draws its children on top of each other. In `MenuCard`, the first child is the centered icon, name and price. The second child is the badge, wrapped in `Positioned(top: 8, left: 8)`, which pins it to the top-left corner of the card above the content. The `if (item.bestSeller)` check adds the badge only to best-selling items.

**9. What is the difference between customizing with `ThemeData` and with a style on one widget? Give one example of each from Activity 5.**
`ThemeData` customizes the look of the whole app from one place, and every matching widget follows it. An example is `elevatedButtonTheme` in `buildTheme()`, which gives every ElevatedButton rounded corners and padding. A style on one widget affects only that widget. An example is `TextStyle(fontWeight: FontWeight.bold)` written directly on a single `Text`.

**10. When you flip the dark-mode switch in Activity 5, which widget holds the state, and how does the change reach `MaterialApp`?**
The state is held by `_ThemeDemoAppState`, which stores the `_isDark` value. The `SwitchListTile` in `SettingsPage` calls the `onDarkChanged` callback, which is `_setDark`. `_setDark` updates `_isDark` inside `setState()`, so `build()` runs again. `MaterialApp` then receives `themeMode: ThemeMode.dark` and switches from `theme` to `darkTheme`. This is called lifting state up, because the page only shows the value and the parent owns it.