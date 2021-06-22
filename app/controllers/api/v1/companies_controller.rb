# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        @companies = Company.all
        render json: @companies
      end
    end
  end
end
