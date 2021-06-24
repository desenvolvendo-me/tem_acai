# frozen_string_literal: true

require "rails_helper"

describe "Companies", type: :request do
  context "GET /api/v1/companies" do
    it "renders all companies" do
      create(:company, name: "Toca do açaí")
      create(:company, name: "Açaí house")
      create(:company, name: "Esquina Açaí")

      get "/api/v1/companies"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(body.size).to eq(3)
      expect(body[0][:name]).to eq("Toca do açaí")
      expect(body[1][:name]).to eq("Açaí house")
      expect(body[2][:name]).to eq("Esquina Açaí")
    end
  end

  context "POST /api/v1/companies" do
    it "creates and returns a company" do
      company_params = {
        name: "Toca do Acai",
        phone: "(11) 1111-1111",
        is_open: false,
        acai_price: 9.99,
        reservation: false,
        delivery: false,
        address_attributes: {
          zip: "111111-111",
          street: "Rua dos Açaís, 140",
          city: "Açaí Town",
          state: "AC"
        }
      }

      post "/api/v1/companies", params: company_params
      body = JSON.parse(response.body, symbolize_names: true)
      company = Company.first

      expect(response).to have_http_status(201)
      expect(company.name).to eq("Toca do Acai")
      expect(company.phone).to eq("(11) 1111-1111")
      expect(company.is_open).to eq(false)
      expect(company.acai_price).to eq(9.99)
      expect(company.reservation).to eq(false)
      expect(company.delivery).to eq(false)
      expect(company.address.street).to eq("Rua dos Açaís, 140")
      expect(body[:name]).to eq("Toca do Acai")
      expect(body[:phone]).to eq("(11) 1111-1111")
      expect(body[:is_open]).to eq(false)
      expect(body[:acai_price]).to eq("9.99")
      expect(body[:reservation]).to eq(false)
      expect(body[:delivery]).to eq(false)
    end

    it "fails to create a company" do
      company_params = {
        phone: "(11) 1111-1111",
        is_open: false,
        acai_price: 9.99,
        reservation: false,
        delivery: false
      }

      post "/api/v1/companies", params: company_params
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(422)
      expect(body[:errors][:name]).to include("can't be blank")
    end
  end
end
