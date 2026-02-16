# Changelog

## Unreleased

## 1.0.0 (2026-02-16)

*   Drop Ruby 3.0 and 3.1 support.
*   Add Ruby 4.0 support.
*   Update runtime dependencies.
*   Update development dependencies.
*   Resolve new RuboCop offenses.
*   Improve CI config.

## 0.11.0 (2025-01-06)

*   Drop Ruby 2.6 and 2.7 support.
*   Add Ruby 3.2, 3.3 and 3.4 support.
*   Lock Ruby version more strict.
    There can be breaking changes in minor updates.
*   Update `formalism` to a new version with fix for `Find` form.
*   Update development dependencies.
*   Resolve new RuboCop offenses.
*   Move development dependencies from `gemspec` into `Gemfile`.

## 0.10.1 (2022-09-24)

*   Allow `gorilla_patch` version 5.
*   Improve CI.

## 0.10.0 (2022-09-24)

*   Update `formalism` to a new version.

## 0.9.0 (2022-09-21)

*   Make `#instance=` public method.
*   Drop Ruby 2.5 support.
*   Add Ruby 3.1 for CI.
*   Update development dependencies.
*   Resolve RuboCop offenses.

## 0.8.0 (2021-02-11)

*   Support Ruby 3.
*   Update development dependencies.

## 0.7.2 (2020-11-11)

*   Fix error with `primary_field`.
*   Fix an error when project has no models (and namespace) yet.
*   Update development dependencies.

## 0.7.1 (2020-10-15)

*   Fix `Delete` form for models without `auditable` plugin.

## 0.7.0 (2020-10-14)

*   Add `primary_field`, don't lock on `id` field.

## 0.6.2 (2020-09-28)

*   Update `formalism` to a new version.

## 0.6.1 (2020-09-28)

*   Fix case when there is instance and `nil` params for `Update` form.

## 0.6.0 (2020-09-23)

*   Fix complex error with `name` of anonymous classes and `inherited`.
    1.  Update `formalism` to a version with `super` in `inherited` method.
    2.  Define non-anonymous classes and modules,
        even `stub_class` or `def self.name` assignes `name` only after `inherited`.
    3.  Yes, I hate `eval`, but I don't know how I can define these things in another working way.
*   Use correct assigned constants, fix broken lookup.
*   Fix `Base#initialize` for cases when there are no `static_cache` plugin at all.

## 0.5.0 (2020-09-22)

*   Require `forwardable` before its usage.

## 0.4.0 (2020-07-10)

*   Remove `puts` about `define_for_project` steps

## 0.3.0 (2020-07-10)

*   Remove debug actions

## 0.2.0 (2020-07-10)

*   Update `flame-pagination` to version `0.3.0`, which allows Flame version 5.

## 0.1.0 (2020-07-10)

*   Initial release.
