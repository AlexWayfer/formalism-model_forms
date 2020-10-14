# Changelog

## master (unreleased)

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
