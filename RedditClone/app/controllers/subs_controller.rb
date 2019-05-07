class SubsController < ApplicationController
    before_action :require_signed_in!

    def new
       @sub = Sub.new 
    end

    def show
        @sub = Sub.find(params[:id])
    end

    def index
        @sub = Sub.all
    end

    def edit
        @sub = Sub.find(params[:id])
    end

    def update
        @sub = current_user.subs.find(params[:id])

        if @sub.update_attributes(sub_params)
            #redirect_to subs_url
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.user_id = current_user.id

        if @sub.save
            redirect_to subs_url
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    private
    def sub_params
        params.require(:sub):permit(:description, :title)
    end



end