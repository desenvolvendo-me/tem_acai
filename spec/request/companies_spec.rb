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
end
