module Api
  module V1
    class Cards < Grape::API
      include Api::V1::Defaults

      helpers do
        def current_user
          @current_user ||= Customer.first #User.authorize!
        end

        def authenticate
          error('401 error', 401) unless current_user
        end
      end

      resource :cards do
        desc 'Return a card balance'
        params do
          requires :id, type: String, desc: 'ID of the card'
        end
        get ':id' do
          Card.where(number: permitted_params[:number]).first!
        end

        desc 'add balance'
        params do
          requires :number, type: String, desc: 'ID of the card'
        end

        post do
          # authenticate
          # logic for adding balance
        end
        
      end
    end
  end
end
