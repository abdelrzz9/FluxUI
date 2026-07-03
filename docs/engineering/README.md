# Flux UI — Engineering Standards

This directory contains all engineering standards, processes, and templates for the Flux UI project.

## Standards

| Document | Description |
|----------|-------------|
| [CODING_STANDARDS.md](CODING_STANDARDS.md) | Naming, formatting, documentation, public API, deprecation, performance, accessibility, testing, animation, theme, null safety, const, builder patterns, composition, RenderObject rules |
| [TESTING.md](TESTING.md) | Unit, widget, golden, integration, accessibility, performance, visual regression, theme, RTL, localization, platform testing |
| [PERFORMANCE.md](PERFORMANCE.md) | Measurable targets, frame budget, animation budget, const rules, widget splitting, RenderObject/CustomPainter criteria, benchmarks |
| [ACCESSIBILITY.md](ACCESSIBILITY.md) | Semantics, keyboard navigation, focus traversal, touch targets, color contrast, large text, reduced motion, RTL, screen readers, desktop accessibility |
| [DESIGN_SYSTEM_RULES.md](DESIGN_SYSTEM_RULES.md) | Immutable spacing, radius, typography, elevation, motion, icon sizing, color usage, state layers, opacity, animation timing — with anti-duplication rule |

## Processes

| Document | Description |
|----------|-------------|
| [CONTRIBUTING.md](CONTRIBUTING.md) | Repository setup, Flutter version, Melos, FVM, test/example commands, adding components, writing docs, PR checklist, review checklist, commit convention, branch naming, release process |
| [RELEASE.md](RELEASE.md) | Release types, pre-release checklist, step-by-step release process, hotfix process, CI automation, package publishing order |
| [VERSIONING.md](VERSIONING.md) | Semantic versioning, breaking change definition, API stability levels, deprecation timeline, release cadence, LTS, migration policy |
| [API_STABILITY.md](API_STABILITY.md) | Maturity levels (Experimental, Preview, Stable, Deprecated, Internal), promotion rules, lifecycle example, tracking |

## Infrastructure

| Document | Description |
|----------|-------------|
| [REPOSITORY_STRUCTURE.md](REPOSITORY_STRUCTURE.md) | Ideal directory layout with explanations for every directory |
| [GITHUB_LABELS.md](GITHUB_LABELS.md) | Complete label taxonomy organized by category (component, primitive, theme, priority, status, release) |
| [GITHUB_MILESTONES.md](GITHUB_MILESTONES.md) | Milestone planning with 14 milestones, timeline, and issue mapping |
| [FINAL_READINESS_REPORT.md](FINAL_READINESS_REPORT.md) | Complete project review with architecture weaknesses, missing docs, risk areas, technical debt, breaking APIs, scalability concerns, and prioritized action items |

## Templates

| Template | Location |
|----------|----------|
| Bug Report | `.github/ISSUE_TEMPLATE/01_bug_report.yml` |
| Feature Request | `.github/ISSUE_TEMPLATE/02_feature_request.yml` |
| Component Proposal | `.github/ISSUE_TEMPLATE/03_component_proposal.yml` |
| Theme Proposal | `.github/ISSUE_TEMPLATE/04_theme_proposal.yml` |
| Performance Issue | `.github/ISSUE_TEMPLATE/05_performance_issue.yml` |
| Accessibility Issue | `.github/ISSUE_TEMPLATE/06_accessibility_issue.yml` |
| Question | `.github/ISSUE_TEMPLATE/07_question.yml` |
| Pull Request | `.github/PULL_REQUEST_TEMPLATE.md` |
| RFC | `.github/RFC_TEMPLATE.md` |

## Quick Reference

### Before Your First PR

1. Read [CONTRIBUTING.md](CONTRIBUTING.md) for setup instructions
2. Read [CODING_STANDARDS.md](CODING_STANDARDS.md) for code style
3. Read [TESTING.md](TESTING.md) for test requirements
4. Use the [PR Checklist](.github/PULL_REQUEST_TEMPLATE.md) before submitting

### Before Your First Component Proposal

1. Read [API_STABILITY.md](API_STABILITY.md) for maturity levels
2. Use the [Component Proposal Template](.github/ISSUE_TEMPLATE/03_component_proposal.yml)
3. Check [COMPONENTS.md](../roadmap/COMPONENTS.md) for existing tracking
