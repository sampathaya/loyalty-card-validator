module Api
  module V1
    class Cards < Grape::API
      include Api::V1::Defaults
      resource :cards do
        desc 'Return all cards'
        get '' do
          Card.all
        end
        desc 'Return a card balance'
        params do
          requires :id, type: String, desc: 'ID of the card'
        end
        get ':id' do
          Card.where(number: permitted_params[:number]).first!
        end
      end
    end
  end
end
