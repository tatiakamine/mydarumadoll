# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mydarumadoll::Application.initialize!

# My own configurations

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  if html_tag =~ /^<input/
    errors = Array(instance_tag.error_message).join(',')
    %(<span class="field_with_errors">#{html_tag}</span><span class="validation-error">&nbsp;#{errors}</span>).html_safe
  else
    %(#{html_tag}).html_safe
  end
end

