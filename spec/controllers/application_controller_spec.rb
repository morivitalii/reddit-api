require "rails_helper"

RSpec.describe ApplicationController do
  context "when Pundit::NotAuthorizedError thrown" do
    controller do
      def index
        raise Pundit::NotAuthorizedError
      end
    end

    context "and user signed in", context: :as_signed_in_user do
      it "responds with 403 http status" do
        allow(controller).to receive(:current_user).and_return(user)

        get :index

        expect(response).to have_http_status(403)
      end
    end

    context "and user signed out", context: :as_signed_out_user do
      it "responds with 401 http status" do
        allow(controller).to receive(:current_user).and_return(user)

        get :index

        expect(response).to have_http_status(401)
      end
    end
  end
end
