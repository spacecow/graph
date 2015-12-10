class RemarksController < ApplicationController
  
  def create
    event_id = params[:event_id]
    run(RemarkRunners::Create, remark_params, event_id) do |on|
      on.success do
        redirect_to event_path(event_id)
      end
    end
  end

  def edit
    event_id = params[:event_id]
    run(RemarkRunners::Edit, params[:id], event_id) do |on|
      on.success do |remark|
        @remark = remark
      end
    end
  end

  def update
    event_id = params[:event_id]
    run(RemarkRunners::Update, params[:id], remark_params) do |on|
      on.success do
        redirect_to event_path(event_id)
      end
    end
  end

  def destroy
    event_id = params[:event_id]
    run(RemarkRunners::Destroy, params[:id]) do |on|
      on.success do
        redirect_to event_path(event_id)
      end
    end
  end

  private

    def remark_params
      params.require(:remark).permit(:content)
    end

end
