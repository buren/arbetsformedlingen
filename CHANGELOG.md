# Change Log

# v0.7.0

This is a pretty big release that adds support Ontology and Taxonomy APIs and completes WSOccupation :tada:

* Implement Ontology API
* Implement Taxonomy API (84 endpoints!)
* Implement remaining WSOccupation API endpoints
* Add `Response#uri` method
* Improved documentation

# v0.6.0

* Return "empty result" object when no results are found
* Fix `workplace.contacts` - [PR #14](https://github.com/buren/arbetsformedlingen/pull/14)
* Fix crashes when ad data doesn't contain some keys  - [PR #15](https://github.com/buren/arbetsformedlingen/pull/15), [PR #11](https://github.com/buren/arbetsformedlingen/pull/11)
* Replace `URI#encode` with `#encode_www_form_component`
* Add `WSOccupationClient` docs
* Refactor `SOAPRequest` to use new `API::Reponse#xml` method
* Add `#response` to `SoklistaPage`, `MatchningPage`, `AdResult` and `Values::Ad`
* Proper `API::Response` class
* Introduce `MatchningPage` `#success?` and `#response`

# v0.5.0

* Upgrade `dry-valdation` dependency from `~> 0.11` to `~> 0.12`
* Commit test vcr cassettes & fix test suite
* Don't crash when no results are returned from API, return empty result
* Make Ad/matchning `sista_ansokningsdag` key optional
* Fix crash when ad data doesn't contain a `varaktighetsId` key

---

## v0.4.1..v0.1.0

Is history..
