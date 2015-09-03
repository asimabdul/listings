module Api
  module V1
    class ListingsController < Api::V1::BaseController
      
      def index
        @listings = Listing.search(filters).page(params[:page])
        pagination_links(@listings, api_v1_listings_url, request.query_parameters)
      end

      private
      def filters
        params.slice(:min_bed, :max_bed, :max_price, :min_price, :max_price, :min_bath, :max_bath)
      end

    end
  end
end