# Change log

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not impact the functionality of the module.

## [v2.0.0](https://github.com/voxpupuli/puppet-logrotate/tree/v2.0.0) (2017-05-25)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.4.0...v2.0.0)

**Closed issues:**

- Support Ubuntu 16.04 [\#59](https://github.com/voxpupuli/puppet-logrotate/issues/59)
- Logrotate rule ERB template should not take variables from the scope object [\#37](https://github.com/voxpupuli/puppet-logrotate/issues/37)
- Ubuntu Xenial 16.04 compaibility [\#34](https://github.com/voxpupuli/puppet-logrotate/issues/34)
- string 'undef' now treated as undef [\#26](https://github.com/voxpupuli/puppet-logrotate/issues/26)
- Allow adjustment of OS-specific defaults [\#9](https://github.com/voxpupuli/puppet-logrotate/issues/9)

**Merged pull requests:**

- Fix typo [\#58](https://github.com/voxpupuli/puppet-logrotate/pull/58) ([gabe-sky](https://github.com/gabe-sky))
- Adding support for maxsize also in main config [\#57](https://github.com/voxpupuli/puppet-logrotate/pull/57) ([seefood](https://github.com/seefood))
- Fix rubocop checks [\#53](https://github.com/voxpupuli/puppet-logrotate/pull/53) ([coreone](https://github.com/coreone))
- Another attempt at FreeBSD support [\#52](https://github.com/voxpupuli/puppet-logrotate/pull/52) ([coreone](https://github.com/coreone))
- Fixes \#34 - Ubuntu Xenial and up support [\#43](https://github.com/voxpupuli/puppet-logrotate/pull/43) ([edestecd](https://github.com/edestecd))
- Fixes \#37 - Logrotate rule ERB template should not take variables from the scope object [\#38](https://github.com/voxpupuli/puppet-logrotate/pull/38) ([imriz](https://github.com/imriz))
- Fix puppet-lint issues and bad style [\#32](https://github.com/voxpupuli/puppet-logrotate/pull/32) ([baurmatt](https://github.com/baurmatt))
- Add gentoo support [\#27](https://github.com/voxpupuli/puppet-logrotate/pull/27) ([baurmatt](https://github.com/baurmatt))

## [v1.4.0](https://github.com/voxpupuli/puppet-logrotate/tree/v1.4.0) (2016-05-30)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.3.0...v1.4.0)

**Closed issues:**

- Optional config settings are no longer optional?!? [\#29](https://github.com/voxpupuli/puppet-logrotate/issues/29)
- wtmp and btmp are different when using the future parser [\#13](https://github.com/voxpupuli/puppet-logrotate/issues/13)

**Merged pull requests:**

- Changed default string "undef" to "UNDEFINED" to work around this bug… [\#28](https://github.com/voxpupuli/puppet-logrotate/pull/28) ([durist](https://github.com/durist))
- Fix typo in README.md [\#25](https://github.com/voxpupuli/puppet-logrotate/pull/25) ([siebrand](https://github.com/siebrand))
- Added ability to override default btmp and/or wtmp [\#21](https://github.com/voxpupuli/puppet-logrotate/pull/21) ([ncsutmf](https://github.com/ncsutmf))
- remove special whitespace character [\#20](https://github.com/voxpupuli/puppet-logrotate/pull/20) ([jfroche](https://github.com/jfroche))
- Update Gemfile for Rake/Ruby version dependencies [\#19](https://github.com/voxpupuli/puppet-logrotate/pull/19) ([ncsutmf](https://github.com/ncsutmf))
- add official puppet 4 support [\#17](https://github.com/voxpupuli/puppet-logrotate/pull/17) ([mmckinst](https://github.com/mmckinst))
- Feature/fix wtmp btmp [\#16](https://github.com/voxpupuli/puppet-logrotate/pull/16) ([robinbowes](https://github.com/robinbowes))

## [v1.3.0](https://github.com/voxpupuli/puppet-logrotate/tree/v1.3.0) (2015-11-05)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.8...v1.3.0)

**Closed issues:**

- The logrotate package should be 'present' by default, or at least tunable [\#11](https://github.com/voxpupuli/puppet-logrotate/issues/11)

**Merged pull requests:**

- Set default package ensure value to 'installed' [\#12](https://github.com/voxpupuli/puppet-logrotate/pull/12) ([natemccurdy](https://github.com/natemccurdy))
- Add support for maxsize directive [\#10](https://github.com/voxpupuli/puppet-logrotate/pull/10) ([zeromind](https://github.com/zeromind))

## [v1.2.8](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.8) (2015-09-14)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.7...v1.2.8)

**Closed issues:**

- Dependency issue in manifests/rule.pp [\#7](https://github.com/voxpupuli/puppet-logrotate/issues/7)

**Merged pull requests:**

- Remove hidden Unicode character \(0x000A\) from comments [\#8](https://github.com/voxpupuli/puppet-logrotate/pull/8) ([antaflos](https://github.com/antaflos))

## [v1.2.7](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.7) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.6...v1.2.7)

## [v1.2.6](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.6) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.5...v1.2.6)

## [v1.2.5](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.5) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.4...v1.2.5)

## [v1.2.4](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.4) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.3...v1.2.4)

**Closed issues:**

- Add puppet-lint exceptions [\#4](https://github.com/voxpupuli/puppet-logrotate/issues/4)
- Don't use getvar in defaults.pp [\#1](https://github.com/voxpupuli/puppet-logrotate/issues/1)

## [v1.2.3](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.3) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.2...v1.2.3)

## [v1.2.2](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.2) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.1...v1.2.2)

**Merged pull requests:**

- Fixed typo which produces a dependency warning [\#2](https://github.com/voxpupuli/puppet-logrotate/pull/2) ([mat1010](https://github.com/mat1010))

## [v1.2.1](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.1) (2015-05-06)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.2.0...v1.2.1)

## [v1.2.0](https://github.com/voxpupuli/puppet-logrotate/tree/v1.2.0) (2015-03-25)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/1.1.1...v1.2.0)

## [1.1.1](https://github.com/voxpupuli/puppet-logrotate/tree/1.1.1) (2013-06-27)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/1.1.0...1.1.1)

## [1.1.0](https://github.com/voxpupuli/puppet-logrotate/tree/1.1.0) (2013-06-09)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/1.0.2...1.1.0)

## [1.0.2](https://github.com/voxpupuli/puppet-logrotate/tree/1.0.2) (2012-10-27)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.0.2...1.0.2)

## [v1.0.2](https://github.com/voxpupuli/puppet-logrotate/tree/v1.0.2) (2012-10-27)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/1.0.1...v1.0.2)

## [1.0.1](https://github.com/voxpupuli/puppet-logrotate/tree/1.0.1) (2012-05-26)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.0.1...1.0.1)

## [v1.0.1](https://github.com/voxpupuli/puppet-logrotate/tree/v1.0.1) (2012-05-26)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/1.0.0...v1.0.1)

## [1.0.0](https://github.com/voxpupuli/puppet-logrotate/tree/1.0.0) (2012-03-04)
[Full Changelog](https://github.com/voxpupuli/puppet-logrotate/compare/v1.0.0...1.0.0)

## [v1.0.0](https://github.com/voxpupuli/puppet-logrotate/tree/v1.0.0) (2012-03-04)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*