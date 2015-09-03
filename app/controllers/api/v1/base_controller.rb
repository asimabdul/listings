module Api
  module V1
    class BaseController < ApplicationController
      
      http_basic_authenticate_with name: "opendoor", password: "foobar"
      protect_from_forgery with: :null_session

      def pagination_links(model_scope, url, query_params)
        next_page = model_scope.current_page+1 if !model_scope.last_page?
        prev_page = model_scope.current_page-1 if !model_scope.first_page?
        
        next_url_params = query_params.merge(:page => next_page)
        prev_url_params = query_params.merge(:page => prev_page)

        @next_page = "#{url}?#{next_url_params.to_param}" if next_page
        @prev_page = "#{url}?#{prev_url_params.to_param}" if prev_page
      end
      
    end
  end
end