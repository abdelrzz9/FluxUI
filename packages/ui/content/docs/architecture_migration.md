# Architecture Migration

This document tracks the migration from the legacy structure to the new package-centric architecture.

## Status: Complete

The migration of the CLI and documentation is complete.

### Key Changes
- `packages/cli` is now the primary source for the FluxUI CLI.
- `tools/cli` has been removed.
- Documentation has been moved to `packages/ui/content/docs`.

## Completed Tasks
1. Move CLI implementation from `tools/cli` to `packages/cli`.
2. Update CLI entrypoints to be direct instead of forwarding.
3. Update Melos scripts to point to `packages/cli`.
4. Remove legacy `tools/cli`.
