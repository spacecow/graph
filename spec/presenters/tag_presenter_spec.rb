require './app/presenters/base_presenter'
require './app/presenters/tag_presenter'

describe TagPresenter do

  let(:presenter){ TagPresenter.new mdl, view }
  let(:mdl){ double :tag }
  let(:view){ double :view }

  subject{ presenter.send function }

  describe "#title" do
    let(:function){ :title }
    before{ expect(mdl).to receive(:title).with(no_args){ :title }}
    it{ should eq :title }
  end
  
  describe "#delete_link" do
    let(:function){ :delete_link }
    before do
      expect(mdl).to receive(:tagable_type).with(no_args){ :tagable_type }
      expect(mdl).to receive(:tagable_id).with(no_args){ :tagable_id }
      expect(mdl).to receive(:id).with(no_args){ :id }
      expect(view).to receive(:tag_path).with(
        :id,tag:{ tagable_type: :tagable_type, tagable_id: :tagable_id }){ :path }
      expect(view).to receive(:link_to).
        with("Delete", :path, method: :delete, data:{confirm:"Are you sure?"}).
        and_return(:link)
    end
    it{ should be :link }
  end
  
end
