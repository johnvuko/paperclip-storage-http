Paperclip storage HTTP
======================

HTTP storage support for paperclip.

Requirements
------------

You must have in your Gemfile:

	gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"


Installation
------------

Include the gem in your Gemfile:

    gem 'paperclip-storage-http', :git => 'https://github.com/jonathantribouharet/paperclip-storage-http'


Usage
-----

Minimal configuration in your model:
	
	class User < ActiveRecord::Base
	
		has_attached_file :avatar,
			:storage => :http,
			:http_url_upload => 'http://mycdn.com/upload',
			:http_url_remove => 'http://mycdn.com/remove',
			:url => "http://mycdn.com/images/:attachment/:id/:style/:basename.:extension"	
			
	end

Custom configuration in your model:
	
	class User < ActiveRecord::Base
	
		has_attached_file :avatar,
			:storage => :http,
			:http_url_upload => 'http://mycdn.com/upload',
			:http_url_remove => 'http://mycdn.com/remove',
			:http_params_upload => {'secret' => 'my_secret_key_for_upload'},
			:http_params_remove => {'secret' => 'my_secret_key_for_remove'},
			:http_param_file_upload => 'file',
			:http_param_path_upload => 'path',
			:http_param_path_remove => 'path',
			:path => ":attachment/:id/:style/:basename.:extension",
			:url => "http://mycdn.com/images/:attachment/:id/:style/:basename.:extension"	
			
	end

* `http_url_upload` is the URL used for upload your file, it's mandatory.
* `http_url_remove` is the URL used for remove your file, it's mandatory.
* `path` is the path send to `http_url_upload` or `http_url_remove`, by default it's `:attachment/:id/:style/:basename.:extension`.
* `url` is the URL used for access to your file, it's mandatory.
* `http_params_upload` is a Hash of parameters that you can pass for the upload, it's optional.
* `http_params_remove` is a Hash of parameters that you can pass for the removal, it's optional.
* `http_param_file_upload` is name of file parameter for upload, by default it's `file`.
* `http_param_path_upload` is name of path parameter for upload, by default it's `path`.
* `http_param_path_remove` is name of path parameter for removal, by default it's `path`.

Requests on `http_url_upload` and `http_url_remove` are always POST.
