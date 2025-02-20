#####

# Changelog

All notable changes to "github-commit-watcher" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Go to [legend](#legend---types-of-changes) for further information about the types of changes.

## [Unreleased]

## [0.8.0] - 2025-02-20

### Added

- New repository to watch. [a0a7f3c](https://github.com/sven-seyfert/github-commit-watcher/commit/a0a7f3c13b20d88d477f90b89d7ac90398397915)

### Changed

- Add optional parameter for '_ExecuteCommand' function. [4b40517](https://github.com/sven-seyfert/github-commit-watcher/commit/4b4051772bdd397a884c90dc610d11e7be616d92)
- Handle commit message as UTF8 string. [87cf0c0](https://github.com/sven-seyfert/github-commit-watcher/commit/87cf0c0e97f212c31f447106b58afe839fdb0687)
- Update .gitignore file. [4e3cee3](https://github.com/sven-seyfert/github-commit-watcher/commit/4e3cee32384ae1086ffd40bf60c81a56e330f688)

### Documented

- Project version bump. [ddd7b31](https://github.com/sven-seyfert/github-commit-watcher/commit/ddd7b31f66b4e9e4d82cbf28436e8da8ac3ec00f)
- Update output data. [dcffd71](https://github.com/sven-seyfert/github-commit-watcher/commit/dcffd71b9584eadaf937028f9205930c3ca558eb)

## [0.7.0] - 2025-01-24

### Changed

- Extent WebEx notification by the time and message of the commit. [350dc5f](https://github.com/sven-seyfert/github-commit-watcher/commit/350dc5fca1ab21302753e4dd35d94ed7ec40ab91)
- WebEx webhook URL defined in a config file instead of being hard coded. [a48943c](https://github.com/sven-seyfert/github-commit-watcher/commit/a48943c0e6d2fd98f68ef72a0a9deca4fe89fd45)

### Documented

- Add configuration section to README.md file. [1a4efa3](https://github.com/sven-seyfert/github-commit-watcher/commit/1a4efa3b51f6e42ad70ef7d8a8ec648070193dbc)
- Project version bump. [7acc64b](https://github.com/sven-seyfert/github-commit-watcher/commit/7acc64b05485125d9c7f6382e6ed5dfc65b4ae55)
- Update output data by adding timespan of the commit message. [11d816b](https://github.com/sven-seyfert/github-commit-watcher/commit/11d816b5cb3c07cfa0e500b3dc3255659fdb345c)

### Fixed

- Wrong markdown syntax. [3874f95](https://github.com/sven-seyfert/github-commit-watcher/commit/3874f9528f603a0f07d692e3739873632d58c102)

## [0.6.0] - 2025-01-17

### Changed

- Extend cURL request command by 'cache-control' header. [538dddd](https://github.com/sven-seyfert/github-commit-watcher/commit/538dddd9e987e0e5149bd69d6e61c80873fe345f)

### Documented

- Project version bump. [1848718](https://github.com/sven-seyfert/github-commit-watcher/commit/18487184040ca91e1103b6fa53019548e4148681)
- Update output data. [d4cb824](https://github.com/sven-seyfert/github-commit-watcher/commit/d4cb82440e207d9b0b91b02ba0961f88b149a117)

## [0.5.0] - 2025-01-14

### Added

- LICENSE.md file. (MIT License). [03dc1a1](https://github.com/sven-seyfert/github-commit-watcher/commit/03dc1a1d0b4544662fba70569c68a0f806b3eccf)
- Progressbar to visualize processing. [f8399b5](https://github.com/sven-seyfert/github-commit-watcher/commit/f8399b58a376260fb7b23aae8dc87105a6b739e5)

### Changed

- Add cURL option '--insecure' to ignore SSL cert verification. [fb963e5](https://github.com/sven-seyfert/github-commit-watcher/commit/fb963e53bae8264a5ce8432e9b0d3d9f9880b9cc)

### Documented

- Project version bump. [37d5a7f](https://github.com/sven-seyfert/github-commit-watcher/commit/37d5a7f426339a14c39ea135e302b55b095040d4)
- Update output data. [f62e74e](https://github.com/sven-seyfert/github-commit-watcher/commit/f62e74ef7be7963ad8688f2e0a53f8eb792addcc)

### Removed

- Unnecessary console write command. [282a384](https://github.com/sven-seyfert/github-commit-watcher/commit/282a384f274699fd2e70619a523167b0a0ff18c1)

## [0.4.0] - 2025-01-13

### Changed

- Set temp string for WebEx channel (old one was already just for the youtube livestream). [7d27efc](https://github.com/sven-seyfert/github-commit-watcher/commit/7d27efc1739ae2e652ee98a4738d7dc94072ab39)

### Documented

- Note about jq usages to shorten separate jq calls. [de091c1](https://github.com/sven-seyfert/github-commit-watcher/commit/de091c1cdad4b0253ca0a7a24aad1580a9befecd)
- Project version bump. [836b698](https://github.com/sven-seyfert/github-commit-watcher/commit/836b69857e3f6501366dc163d93a67ee00d3e2c3)
- Update output data. [f15ef48](https://github.com/sven-seyfert/github-commit-watcher/commit/f15ef483f5e0748253c16a12c0b32d4462013afe)

### Removed

- Invalid executable (because of temp string WebEx channel). [09eb091](https://github.com/sven-seyfert/github-commit-watcher/commit/09eb09103faa04a4f1fd81d399e003cade93c6ce)

## [0.3.0] - 2025-01-12

### Added

- Added: CHANGELOG.md file. [577c9f2](https://github.com/sven-seyfert/github-commit-watcher/commit/577c9f233e665c2b145fb32ff0806cc74d521a31)

### Changed

- Extend webex notification message by links. [05920b4](https://github.com/sven-seyfert/github-commit-watcher/commit/05920b400ca559be5d68c0820618a89d7ac9e0a6)
- Project version bump. [9931ec4](https://github.com/sven-seyfert/github-commit-watcher/commit/9931ec451cecced41ecf1b7d1c99241e2aa91749)
- Remove ignored output folder from .gitignore file. [90f0385](https://github.com/sven-seyfert/github-commit-watcher/commit/90f03854de746e865f558d798df209d393589a54)

### Refactored

- Replace AutoIt StringReplace() usage by jq option '-j'. [873df94](https://github.com/sven-seyfert/github-commit-watcher/commit/873df945ef45d4b54d1b29a617cdce1ae5e98f34)

## [0.2.0] - 2024-01-09

### Changed

- Project version bump. [cf76fce](https://github.com/sven-seyfert/github-commit-watcher/commit/cf76fcee5120da2f1ca0441d9e5bb4df080fde61)

### Refactored

- Small variable scope adjustment. [52bcd71](https://github.com/sven-seyfert/github-commit-watcher/commit/52bcd711290f148916a987b4b5d155c61fc1007a)

### Removed

- Unnecessary main_stripped.au3 file. [06af9da](https://github.com/sven-seyfert/github-commit-watcher/commit/06af9da88fbf1146434f2e086d0f87c06a9a92fd)

## [0.1.0] - 2025-01-09

### Added

- Initial commit (first running stable state). [b3b0fb7](https://github.com/sven-seyfert/github-commit-watcher/commit/b3b0fb758b1ca15bf43ed9514ed4e6016c29c213)

[Unreleased]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.8.0...HEAD
[0.8.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/sven-seyfert/github-commit-watcher/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/sven-seyfert/github-commit-watcher/releases/tag/v0.1.0

---

### Legend - Types of changes

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Documented` for documentation only changes.
- `Fixed` for any bug fixes.
- `Refactored` for changes that neither fixes a bug nor adds a feature.
- `Removed` for now removed features.
- `Security` in case of vulnerabilities.
- `Styled` for changes like whitespaces, formatting, missing semicolons etc.

##

[To the top](#)
