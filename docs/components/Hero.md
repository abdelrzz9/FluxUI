# FluxHero

## Overview

A prominent hero section for landing pages and marketing content. Combines a heading, subtext, and optional CTA.

## Flutter API

```dart
FluxHero(
  title: 'Build Faster',
  subtitle: 'Professional-grade UI components with MicroClub DNA',
  background: GradientBackground(...),
  actions: [
    FluxButton(child: Text('Get Started')),
    FluxButton.variant(FluxButtonVariant.outline, child: Text('Learn more')),
  ],
)
```

## Properties

| Property | Type | Description |
|----------|------|-------------|
| title | String | Main heading |
| subtitle | String? | Supporting text |
| background | Widget? | Background decoration |
| actions | List<Widget>? | CTA buttons |
| align | TextAlign | Text alignment |
| size | HeroSize | Size variant |
