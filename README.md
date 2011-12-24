Paperclip storage HTTP
======================

Http storage support for paperclip.


Installation
------------

Include the gem in your Gemfile:

    gem 'paperclip-storage-http', :git => 'https://github.com/eviljojo22/paperclip-storage-http'


Usage
-----

In your model:
	
	class User < ActiveRecord::Base
	
		has_attached_file :avatar,
			:storage => :http,
			:http_url_upload => 'http://mycdn.com/upload',
			:http_url_remove => 'http://mycdn.com/remove',
			:http_params_upload => {'secret' => 'my_secret_key_for_upload'},
			:http_params_remove => {'secret' => 'my_secret_key_for_remove'},
			:path => ":attachment/:id/:style/:basename.:extension",
			:url => "http://mycdn.com/images/:attachment/:id/:style/:basename.:extension"	
			
	end

* `http_url_upload` is the URL used for upload your file, it's mandatory.
* `http_url_remove` is the URL used for remove your file, it's mandatory.
* `url` is the URL used for access to your file, it's mandatory.
* `path` is the path send to `http_url_upload` or `http_url_remove`, by default it's `:attachment/:id/:style/:basename.:extension`.
* `http_params_upload` is a Hash of parameters that you can pass for the upload, it's optional.
* `http_params_remove` is a Hash of parameters that you can pass for the removal, it's optional.

Requests on `http_url_upload` and `http_url_remove` are always POST.
