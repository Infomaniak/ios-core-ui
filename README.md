# ios-core-ui
UI component collection

## Avatars

`InitialsView` and `AvatarImage` adapt to the space proposed by their parent,
without a `size` argument. Apply `.frame(width:height:)` at the call site when
an avatar needs fixed dimensions. When migrating from the previous API, move
`size: diameter` to `.frame(width: diameter, height: diameter)`.
The size-based initializers have been removed; this is a breaking API change.

## Device hinge detection

Install `.detectDeviceHinge(store: .standard)` on an ancestor of views that read
`@Environment(\.hasDeviceHinge) private var hasDeviceHinge`. The modifier must wrap
the environment-reading view or modifier; an environment value does not propagate
back up to the view installing it.

The store defaults to `.standard`; supply a custom `UserDefaults` to
`.detectDeviceHinge(store:)` or `IKDeviceHingeDetectorModifier(store:)` when needed.
Positive detection is persisted under `com.infomaniak.coreui.deviceHasHinge` and is
available to descendants on their first render on subsequent launches. Missing
hinge reports never clear a confirmed detection. On a fresh install (or after
clearing app preferences), the value is `false` until iOS reports a hinge, so an
initial layout transition is still possible. Detection uses iOS 27.1 or later
and is unavailable in Mac Catalyst. Other platforms still receive the persisted
value, defaulting to `false`.

`ikFloatingActionButton` installs detection automatically. The former
`IKDeviceHingeState.shared` observable singleton has been removed; use the
environment value instead.
