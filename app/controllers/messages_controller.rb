class MessagesController < ApplicationController
    before_action :find_message, only: [:show, :update, :destroy]

    def index
        @messages = Message.order('updated_at DESC')
        render json: @messages
    end

    def create
        @message = Message.create(message_params)
        if @message.errors.any?
            render json: @message.errors, status: :unprocessable_entity
        else
            render json: @message, status: 201
        end
    end

    def update
        @message.update(message_params)
        if @message.errors.any?
            render json: @message.errors, status: :unprocessable_entity
        else
            render json: @message, status: 201
        end
    end

    def show
        render json: @message
    end

    def destroy
        @message.delete
        render json: {message: "Message deleted"}, status: 204
    end

    def find_message
        begin
            @message = Message.find(params[:id])
        rescue
            render json: {error: "message does not exist"}, status: 404
        end
    end
    private
    def message_params
        params.require(:message).permit(:m_text)
    end
end