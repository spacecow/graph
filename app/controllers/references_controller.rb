class ReferencesController < ApplicationController

  def show
    @reference = run(ReferenceRunners::Show, params[:id])
  end

  def create
    run(ReferenceRunners::Create, reference_params) do |on|
      on.success do |reference|
        redirect_to note_path(reference.note_id)
      end
    end
  end

  def edit
    @reference = run(ReferenceRunners::Show, params[:id])
  end

  def update
    run(ReferenceRunners::Update, params[:id], reference_params) do |on|
      on.success do |reference|
        redirect_to reference_path(reference.id)
      end
    end
  end

  private

    def reference_params
      params.require(:reference).permit(:note_id, :image, :url, :comment)
    end

end
