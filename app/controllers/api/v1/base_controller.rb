module Api
  module V1
    class BaseController < ApplicationController
      
      http_basic_authenticate_with name: "opendoor", password: "foobar"
      protect_from_forgery with: :null_session

      def pagination_links(model_scope, url, query_params)
        next_page = model_scope.current_page+1 if !model_scope.last_page?
        prev_page = model_scope.current_page-1 if !model_scope.first_page?

        if !model_scope.first_page?
          prev_page = model_scope.current_page-1
          @first_page = "<#{url}?#{query_params.merge(:page => 1).to_param}>; rel=first"
        end

        if !model_scope.last_page?
          next_page = model_scope.current_page+1
          @last_page = "<#{url}?#{query_params.merge(:page => model_scope.total_pages).to_param}>; rel=last"
        end
        
        next_url_params = query_params.merge(:page => next_page)
        prev_url_params = query_params.merge(:page => prev_page)

        @next_page = "<#{url}?#{next_url_params.to_param}>; rel=next" if next_page
        @prev_page = "<#{url}?#{prev_url_params.to_param}>; rel=prev" if prev_page

        links = []

        links << @next_page
        links << @prev_page
        links << @first_page
        links << @last_page

        links
        
      end
      
    end
  end
end