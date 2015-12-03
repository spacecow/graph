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

    describe Show do
      let(:relation){ double :relation } 
      before do
        expect(repo).to receive(:relation).with(:id){ relation }
        expect(repo).to receive(:new_reference).
          with(referenceable_id: :id, referenceable_type:"Relation"){ :reference }
        expect(relation).to receive(:references).with(no_args){ :references }
      end
      subject{ Show.new(context).run :id }
      it{ subject }
    end

    #describe Create do
    #  subject{ Create.new(context).run }
    #  it{ subject }
    #end

  end

end
