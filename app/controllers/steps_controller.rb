class StepsController < ApplicationController

  def create
    run(StepRunners::Create, step_params) do |on|
      on.success do |step|
        redirect_to event_path(step.child_id)
      end
    end
  end

  private

    def step_params
      params.require(:step).permit(:parent_id, :child_id)
    end

end
