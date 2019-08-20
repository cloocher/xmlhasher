# Changelog

All changes to the XmlHasher gem are documented here. Releases follow semantic versioning.

## [Unreleased]

- Resolve gem build warnings .
- Run tests on CI
- Little refactoring for Node hash builder.

## [1.0.5] - 2019-06-16

- Updated ox version.
- Fixed warning for global variable `$INPUT_RECORD_SEPARATOR`.
- CHANGELOG.md added.
- Use new ruby style guide and `rubocop` gem.
- Added transform cache for keys.

## [1.0.4] - 2018-09-20

- Added `rake benchmark` command.
- Enabled CDATA parsing.
- Cleanup travis config.
- Updated ox version.

## [1.0.3] - 2018-09-20

- Updated ruby version requirement.
- Fix deprecation warning on SimpleCov::Formatter::MultiFormatter use.
- Update dependencies.

## [1.0.2] - 2016-02-20

- Cleaned up support environments.
- Updated ruby version requirement.

## [1.0.1] - 2016-02-20

- Bumped OX and escape_utils gem dependency versions.


## [1.0.0] - 2016-02-20

- Small changes in README.md.
- Removed roby-head from Travis - too unstable.
- Fixed ruby 2.2+ issue with single node parsing.

## [0.0.6] - 2013-09-09

- Added script for benchmarks.
- Added 'string_keys' option to keep keys at Strings vs Symbols.

## [0.0.5] - 2013-04-24

- Test release (CI).

## [0.0.4] - 2013-04-24

- Fixed mixed children array detection.
- Enable Coveralls.
- Add more examples and license into README.md

## [0.0.3] - 2013-04-24

- Added escape method for attributes and dependency from `escape_utils` gem.
- Some fixes for node children parsing.
- Added more tests.

## [0.0.2] - 2013-04-24

- Some fixes for node children parsing.
- Add more tests.
- Updated gem description.

## [0.0.1] - 2013-04-24

- The first implementation of the XML parser.
