class ReferencesController < ApplicationController

  def create
    run(ReferenceRunners::Create, reference_params) do |on|
      on.success do |reference|
        redirect_to universes_path #note_path reference.note_id
      end
    end
  end

  private

    def reference_params
      params.require(:reference).permit(:note_id, :image)
    end

end