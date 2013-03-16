--- !ruby/object:Gem::Specification
name: linkedin
version: !ruby/object:Gem::Version
  version: 0.3.7
  prerelease: 
platform: ruby
authors:
- Wynn Netherland
- Josh Kalderimis
autorequire: 
bindir: bin
cert_chain: []
date: 2012-05-30 00:00:00.000000000 Z
dependencies:
- !ruby/object:Gem::Dependency
  name: hashie
  requirement: &70192547125300 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '1.2'
  type: :runtime
  prerelease: false
  version_requirements: *70192547125300
- !ruby/object:Gem::Dependency
  name: multi_json
  requirement: &70192547123600 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '1.0'
  type: :runtime
  prerelease: false
  version_requirements: *70192547123600
- !ruby/object:Gem::Dependency
  name: oauth
  requirement: &70192547122740 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '0.4'
  type: :runtime
  prerelease: false
  version_requirements: *70192547122740
- !ruby/object:Gem::Dependency
  name: json
  requirement: &70192547121960 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '1.6'
  type: :development
  prerelease: false
  version_requirements: *70192547121960
- !ruby/object:Gem::Dependency
  name: rake
  requirement: &70192547137360 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '0.9'
  type: :development
  prerelease: false
  version_requirements: *70192547137360
- !ruby/object:Gem::Dependency
  name: rdoc
  requirement: &70192547136900 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '3.8'
  type: :development
  prerelease: false
  version_requirements: *70192547136900
- !ruby/object:Gem::Dependency
  name: rspec
  requirement: &70192547136400 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '2.6'
  type: :development
  prerelease: false
  version_requirements: *70192547136400
- !ruby/object:Gem::Dependency
  name: simplecov
  requirement: &70192547135880 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '0.5'
  type: :development
  prerelease: false
  version_requirements: *70192547135880
- !ruby/object:Gem::Dependency
  name: vcr
  requirement: &70192547135320 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '1.10'
  type: :development
  prerelease: false
  version_requirements: *70192547135320
- !ruby/object:Gem::Dependency
  name: webmock
  requirement: &70192547134760 !ruby/object:Gem::Requirement
    none: false
    requirements:
    - - ~>
      - !ruby/object:Gem::Version
        version: '1.7'
  type: :development
  prerelease: false
  version_requirements: *70192547134760
description: Ruby wrapper for the LinkedIn API
email:
- wynn.netherland@gmail.com
- josh.kalderimis@gmail.com
executables: []
extensions: []
extra_rdoc_files: []
files:
- .autotest
- .document
- .gemtest
- .gitignore
- .rspec
- .travis.yml
- Gemfile
- LICENSE
- README.markdown
- Rakefile
- changelog.markdown
- examples/authenticate.rb
- examples/network.rb
- examples/profile.rb
- examples/sinatra.rb
- examples/status.rb
- lib/linked_in/api.rb
- lib/linked_in/api/query_methods.rb
- lib/linked_in/api/update_methods.rb
- lib/linked_in/client.rb
- lib/linked_in/errors.rb
- lib/linked_in/helpers.rb
- lib/linked_in/helpers/authorization.rb
- lib/linked_in/helpers/request.rb
- lib/linked_in/mash.rb
- lib/linked_in/search.rb
- lib/linked_in/version.rb
- lib/linkedin.rb
- linkedin.gemspec
- spec/cases/api_spec.rb
- spec/cases/linkedin_spec.rb
- spec/cases/mash_spec.rb
- spec/cases/oauth_spec.rb
- spec/cases/search_spec.rb
- spec/fixtures/cassette_library/LinkedIn_Api/Company_API.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_authorize_from_request.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_request_token.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_request_token/with_a_callback_url.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_request_token/with_default_options.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_company_name_option.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_first_name_and_last_name_options.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_first_name_and_last_name_options_with_fields.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_keywords_string_parameter.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_single_keywords_option.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_single_keywords_option_with_pagination.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_keywords_options_with_fields.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_keywords_string_parameter.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option_with_a_facet.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option_with_facets_to_return.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option_with_pagination.yml
- spec/helper.rb
homepage: http://github.com/pengwynn/linkedin
licenses: []
post_install_message: 
rdoc_options: []
require_paths:
- lib
required_ruby_version: !ruby/object:Gem::Requirement
  none: false
  requirements:
  - - ! '>='
    - !ruby/object:Gem::Version
      version: '0'
required_rubygems_version: !ruby/object:Gem::Requirement
  none: false
  requirements:
  - - ! '>='
    - !ruby/object:Gem::Version
      version: '0'
requirements: []
rubyforge_project: 
rubygems_version: 1.8.11
signing_key: 
specification_version: 3
summary: Ruby wrapper for the LinkedIn API
test_files:
- spec/cases/api_spec.rb
- spec/cases/linkedin_spec.rb
- spec/cases/mash_spec.rb
- spec/cases/oauth_spec.rb
- spec/cases/search_spec.rb
- spec/fixtures/cassette_library/LinkedIn_Api/Company_API.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_authorize_from_request.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_request_token.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_request_token/with_a_callback_url.yml
- spec/fixtures/cassette_library/LinkedIn_Client/_request_token/with_default_options.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_company_name_option.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_first_name_and_last_name_options.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_first_name_and_last_name_options_with_fields.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_keywords_string_parameter.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_single_keywords_option.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search/by_single_keywords_option_with_pagination.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_keywords_options_with_fields.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_keywords_string_parameter.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option_with_a_facet.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option_with_facets_to_return.yml
- spec/fixtures/cassette_library/LinkedIn_Search/_search_company/by_single_keywords_option_with_pagination.yml
- spec/helper.rb
has_rdoc: 
