unless defined?(require_dependency)
  def require_dependency(*files)
    require *files
  end
end

require './app/runners/relation_runners'

module RelationRunners
  
  describe RelationRunners do
    let(:context){ double :context, repo:repo }
    let(:repo){ double :repo }
    let(:mdl){ double :relation } 

    describe Show do
      before do
        expect(repo).to receive(:relation).with(:id){ mdl }
        expect(repo).to receive(:new_reference).
          with(referenceable_id: :id, referenceable_type:"Relation"){ :reference }
        expect(mdl).to receive(:references).with(no_args){ :references }
      end
      subject{ Show.new(context).run :id }
      it{ should eq [mdl, :reference, :references] }
    end

    describe Create do
      before do
        expect(repo).to receive(:save_relation).with(:params){ :relation }
      end
      subject{ Create.new(context).run :params }
      it{ should eq [:relation] }
    end

    describe Edit do
      before do
        expect(repo).to receive(:relation).with(:id){ :relation }
        expect(repo).to receive(:relation_types).with(no_args){ ["Owner"] }
      end
      subject{ Edit.new(context).run :id }
      it{ should eq [:relation, [["Owner", "Owner"]]] }
    end

    describe Update do
      before do
        expect(repo).to receive(:update_relation).with(:id, :params){ :mdl }
      end
      subject{ Update.new(context).run :id, :params }
      it{ should be :mdl } 
    end

    describe Invert do
      before do
        expect(repo).to receive(:invert_relation).with(:id){ :relation }
      end
      subject{ Invert.new(context).run :id }
      it{ should be :relation }
    end

  end

end
