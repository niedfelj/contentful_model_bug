# README

How to recreate contentful bug:

* bundle install

```bundle install```

* You can create a new space using the included contentful-schema.json
```
contentful_bootstrap create_space demobug --json-template contentful-schema.json
```
* Make sure you fill in your management API key in the config/initializers/contentful.rb

* Then type:
```
rails c
```
* Then do the following:

```
section = Contentful::Section.find_by(slug: 'notebook').load.first

# Try to just create a new Article:

article = Contentful::Article.create(title: 'test')

# That should work fine. Now try to add a section to it and save it:

article.section = section
article.save

# That should fail with a stack too deep error. If you do this, it will save:

article.section = nil
article.save

# You can create an article correctly if you do this

article = Contentful::Article.create(title: 'test', section: section)

# It seems that there is something preventing updates to the section (the weird thing is that other fields work, including categories)
# The bug seems related to the fact that Contentful::Article.as_json just keeps recursively calling as_json, because the activesupport
# as_json for an Object calls instance_values.as_json (which is a hash, but keeps containing a reference to the class that returns the same hash @referenced_class)

```
2.4.1 :015 > Contentful::Article.as_json
SystemStackError: stack level too deep
  from (irb):15
2.4.1 :016 > Contentful::Article.instance_values
 => {"query"=>#<ContentfulModel::Query:0x007f9d633ce558 @parameters={}, @referenced_class=Contentful::Article>, "content_type_id"=>"article", "management"=>#<ContentfulModel::Management:0x007f9d633c7fa0 @configuration={:api_url=>"api.contentful.com", :uploads_url=>"upload.contentful.com", :api_version=>"1", :secure=>true, :default_locale=>"en-US", :gzip_encoded=>false, :logger=>false, :log_level=>1, :raise_errors=>true, :dynamic_entries=>[], :proxy_host=>nil, :proxy_port=>nil, :proxy_username=>nil, :proxy_password=>nil, :max_rate_limit_retries=>1, :max_rate_limit_wait=>60, :application_name=>nil, :application_version=>nil, :integration_name=>"contentful_model", :integration_version=>"0.2.0"}, @logger=false, @access_token="REMOVED", @dynamic_entry_cache={:article=>Contentful::Management::DynamicEntry[article]}, @version=nil, @organization_id=nil, @content_type_id=nil, @zero_length=false>} 
```

# You can put logging code into .rvm/gems/ruby-2.4.1/gems/activesupport-5.1.3/lib/active_support/core_ext/object/json.rb to see just keep calling instance_values (line 54) 




