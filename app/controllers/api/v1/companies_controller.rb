# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        @companies = Company.all
        render json: @companies
      end

      def create
        company = Company.new(company_params)

        if company.save
          render json: company, status: :created
        else
          render json: { errors: company.errors }, status: :unprocessable_entity
        end
      end

      private

      def company_params
        params.permit(:name, :phone, :is_open, :acai_price, :reservation, :delivery,
                      address_attributes: [:zip, :street, :city, :state])
      end
    end
  end
end
