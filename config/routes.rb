# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :companies, only: %i[index create] do
        patch "inform_open"
        patch "inform_closed"
      end
    end
  end
end
