# Flux UI — GitHub Labels

## Category Labels

### Component Labels
| Label | Color | Description |
|-------|-------|-------------|
| `component:button` | `#0052cc` | FluxButton |
| `component:card` | `#0052cc` | FluxCard |
| `component:checkbox` | `#0052cc` | FluxCheckbox |
| `component:switch` | `#0052cc` | FluxSwitch |
| `component:radio` | `#0052cc` | FluxRadio |
| `component:slider` | `#0052cc` | FluxSlider |
| `component:text-field` | `#0052cc` | FluxTextField |
| `component:select` | `#0052cc` | FluxSelect |
| `component:dropdown` | `#0052cc` | FluxDropdownMenu |
| `component:otp` | `#0052cc` | FluxInputOtp |
| `component:dialog` | `#0052cc` | FluxDialog |
| `component:bottom-sheet` | `#0052cc` | FluxBottomSheet |
| `component:popover` | `#0052cc` | FluxPopover |
| `component:tooltip` | `#0052cc` | FluxTooltip |
| `component:toast` | `#0052cc` | FluxToast |
| `component:alert` | `#0052cc` | FluxAlert |
| `component:progress` | `#0052cc` | FluxProgress |
| `component:skeleton` | `#0052cc` | FluxSkeleton |
| `component:tabs` | `#0052cc` | FluxTabs |
| `component:accordion` | `#0052cc` | FluxAccordion |
| `component:table` | `#0052cc` | FluxTable |
| `component:timeline` | `#0052cc` | FluxTimeline |
| `component:carousel` | `#0052cc` | FluxCarousel |
| `component:avatar` | `#0052cc` | FluxAvatar |
| `component:badge` | `#0052cc` | FluxBadge |
| `component:chip` | `#0052cc` | FluxChip |
| `component:tag` | `#0052cc` | FluxTag |
| `component:divider` | `#0052cc` | FluxDivider |
| `component:drawer` | `#0052cc` | FluxDrawer |
| `component:nav-rail` | `#0052cc` | FluxNavigationRail |
| `component:breadcrumb` | `#0052cc` | FluxBreadcrumb |
| `component:pagination` | `#0052cc` | FluxPagination |
| `component:hero` | `#0052cc` | FluxHero |
| `component:empty-state` | `#0052cc` | FluxEmptyState |
| `component:error-state` | `#0052cc` | FluxErrorState |
| `component:loading` | `#0052cc` | FluxLoading |
| `component:masonry` | `#0052cc` | FluxMasonry |
| `component:grid` | `#0052cc` | FluxGrid |
| `component:stack` | `#0052cc` | FluxStack |
| `component:overlay` | `#0052cc` | FluxOverlay |

### Primitive Labels
| Label | Color | Description |
|-------|-------|-------------|
| `primitive:pressable` | `#5319e7` | FluxPressable |
| `primitive:focus-ring` | `#5319e7` | FluxFocusRing |
| `primitive:animated-vis` | `#5319e7` | FluxAnimatedVisibility |
| `primitive:provider` | `#5319e7` | FluxProvider |
| `primitive:portal` | `#5319e7` | FluxPortal |
| `primitive:icon` | `#5319e7` | FluxIcon |
| `primitive:text` | `#5319e7` | FluxText |

### Theme Labels
| Label | Color | Description |
|-------|-------|-------------|
| `theme:core` | `#bfdadc` | Core theme infrastructure |
| `theme:color` | `#bfdadc` | Color tokens and themes |
| `theme:typography` | `#bfdadc` | Typography system |
| `theme:spacing` | `#bfdadc` | Spacing tokens |
| `theme:motion` | `#bfdadc` | Animation/motion system |
| `theme:high-contrast` | `#bfdadc` | High contrast theme |
| `theme:dynamic-color` | `#bfdadc` | Material You dynamic color |

### Cross-Cutting Labels
| Label | Color | Description |
|-------|-------|-------------|
| `accessibility` | `#008000` | Accessibility issue |
| `animation` | `#008672` | Animation/motion |
| `performance` | `#fbca04` | Performance issue |
| `testing` | `#fef2c0` | Testing infrastructure |
| `documentation` | `#0075ca` | Documentation |
| `ci/cd` | `#0e8a16` | CI/CD pipeline |
| `cli` | `#5319e7` | CLI tooling |
| `developer-experience` | `#6f42c1` | DevEx improvements |

### Priority Labels
| Label | Color | Description |
|-------|-------|-------------|
| `priority:critical` | `#b60205` | Must fix immediately |
| `priority:high` | `#d93f0b` | Important, next milestone |
| `priority:medium` | `#fbca04` | Important but not urgent |
| `priority:low` | `#0e8a16` | Nice to have |

### Status Labels
| Label | Color | Description |
|-------|-------|-------------|
| `status:needs-design` | `#e99695` | Needs API/UX design |
| `status:needs-discussion` | `#e99695` | Needs team discussion |
| `status:blocked` | `#b60205` | Blocked by dependency |
| `status:good-first-issue` | `#7057ff` | Good for new contributors |
| `status:help-wanted` | `#008672` | Community contribution welcome |
| `status:breaking-change` | `#b60205` | Breaking API change |
| `status:duplicate` | `#cfd3d7` | Duplicate issue |
| `status:wontfix` | `#cfd3d7` | Will not address |

### Release Labels
| Label | Color | Description |
|-------|-------|-------------|
| `release` | `#5319e7` | Release checklist PR |
| `release:patch` | `#5319e7` | Patch release |
| `release:minor` | `#5319e7` | Minor release |
| `release:major` | `#5319e7` | Major release |

## Label Sync

Labels are maintained via a GitHub Action (`label-sync.yml`) that reads from `.github/labels.yml`. Manual label changes in the repo are overwritten by the action — always modify the YAML file.

```yaml
# .github/labels.yml
- name: "component:button"
  color: "0052cc"
  description: "FluxButton"
```
