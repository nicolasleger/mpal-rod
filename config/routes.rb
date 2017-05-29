Rails.application.routes.draw do
  scope "/api" do
    namespace "v1", format: false do
      resources :intervenants, only: [:index]
    end
  end
end

