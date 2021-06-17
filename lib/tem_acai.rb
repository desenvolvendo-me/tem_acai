# frozen_string_literal: true

require "active_support/core_ext"
require_relative "tem_acai/version"
require_relative "tem_acai/company"
require_relative "tem_acai/company_address"
require_relative "tem_acai/rating"
require_relative "tem_acai/customer_address"
require_relative "tem_acai/purchase"
require_relative "tem_acai/sale"
require_relative "tem_acai/provider"

module TemAcai
  class Error < StandardError; end
  # Your code goes here...
end
