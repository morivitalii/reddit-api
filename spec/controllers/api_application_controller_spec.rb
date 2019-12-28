require "rails_helper"

RSpec.describe ApiApplicationController do
  context "when Pundit::NotAuthorizedError thrown" do
    controller do
      def index
        raise Pundit::NotAuthorizedError
      end
    end

    it "responds with 403 http status" do
      get :index

      expect(response).to have_http_status(403)
    end
  end
end
