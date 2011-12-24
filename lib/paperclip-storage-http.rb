module Paperclip
  module Storage
    module Http

      def self.extended base
				require 'open-uri'
				require 'curb'
				
				base.instance_eval do
					raise "http_url_upload must be set" if !@options[:http_url_upload]
					raise "http_url_remove must be set" if !@options[:http_url_remove]
					raise "url must be set" if !@options[:url]
					
					@http_url_upload = @options[:http_url_upload]
					@http_url_remove = @options[:http_url_remove]
					@http_params_upload = @options[:http_params_upload] || {}
					@http_params_remove = @options[:http_params_remove] || {}
					
					@http_param_file_upload = @options[:http_param_file_upload] .to_s || 'file'
					@http_param_path_upload = @options[:http_param_path_upload].to_s || 'path'
					@http_param_path_remove = @options[:http_param_path_remove].to_s || 'path'

					@options[:path] ||= ":attachment/:id/:style/:basename.:extension"
				end
			end
						
			def exists?(style = default_style)
        if original_filename
					begin
						!!open(url(style))
					rescue
						return false
					end
        else
          false
        end				
      end			

			def to_file(style = default_style)
				return @queued_for_write[style] if @queued_for_write[style]
				open(url(style))
      end

			def flush_writes
				@queued_for_write.each do |style, file|
					options = [Curl::PostField.file(@http_param_file_upload, file.path), Curl::PostField.content(@http_param_path_upload, path(style))]
					for key,value in @http_params_upload
						options << Curl::PostField.content(key.to_s, value.to_s)
					end
					
					Curl::Easy.http_post(@http_url_upload, options)
				end
				@queued_for_write = {}
			end
			
			def flush_deletes
				@queued_for_delete.each do |path|
					options = [Curl::PostField.content(@http_param_path_remove, path)]
					for key,value in @http_params_remove
						options << Curl::PostField.content(key, value)
					end
						
					Curl::Easy.http_post(@http_url_remove, options)
				end
				@queued_for_delete = []
			end

		end
	end
end
