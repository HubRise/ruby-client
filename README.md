# hubrise_ruby_lib

To upload the latest version to RubyGems.org:

1. Increase version in `lib/hubrise_client/version.rb` and commit

2. Build & publish (assuming the new version is `2.0.1`):

```bash
gem build hubrise_client
gem push hubrise_client-2.0.1.gem
``` 
