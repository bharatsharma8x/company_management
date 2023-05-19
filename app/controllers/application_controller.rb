class ApplicationController < ActionController::Base
  # before_action :remove_whitespace

  # def sanitize_data(hash)
  #   result_hash = {}
  #   return hash unless hash.respond_to?(:keys)

  #   hash.keys.each do |key|
  #     result_hash[key] = hash[key].squish if hash[key].is_a?(String)
  #   end

  #   result_hash
  # end

  # def remove_whitespace
  #   params.keys.each do |key|
  #     if params[key].respond_to?(:each)
  #       params[key] = sanitize_data(params[key])
  #      elsif params[key].is_a?(String)
  #       params[key] = params[key].squish
  #      else
  #       params[key] = params[key]
  #      end
  #   end
  # end
end
