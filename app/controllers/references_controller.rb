class ReferencesController < ApplicationController

  def show
    @reference = run(ReferenceRunners::Show, params[:id])
  end

  def create
    run(ReferenceRunners::Create, reference_params) do |on|
      on.success do |reference|
        redirect_to note_path(reference.referenceable_id)
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
      params.require(:reference).
        permit(:referenceable_id, :image, :url, :comment, :referenceable_type)
#TODO merge referenceable_id/type instead of hidden fields in form
    end

end
