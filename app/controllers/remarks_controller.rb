class RemarksController < ApplicationController
  
  def create
    event_id = params[:event_id]
    run(RemarkRunners::Create, remark_params, event_id) do |on|
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
