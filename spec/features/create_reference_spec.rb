require 'rails_helper'
require 'vcr_helper'

describe "Create reference" do

  it "Successfully to relation" do
    VCR.use_cassette("create_reference_to_relation_successfully") do
      begin
        universe = create :universe 
        origin = create :article, universe_id:universe.id
        target = create :article, universe_id:universe.id
        relation = create :relation, origin_id:origin.id, target_id:target.id,
          type:"Husband"
        visit relation_path relation.id
        fill_in 'Comment', with:"once upon a time"
        click_on 'Add'
        expect(current_path).to eq relation_path(relation.id)
        expect(page).to have_content "once upon a time"
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

  it "Successfully to note" do
    VCR.use_cassette("create_reference_to_note_successfully") do
      begin
        universe = create :universe
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id
        tcreate :article_note, article_id:article.id, note_id:note.id
        visit note_path note.id
        attach_file('Image', Rails.root + 'spec/pear.jpeg')
        fill_in 'Comment', with:'smart'
        fill_in 'Url', with:'www.example.com'
        click_on 'Create Reference'
        expect(current_path).to eq note_path(note.id)
        expect(page).to have_content 'smart' 
        expect(page).to have_content 'www.example.com' 
      ensure
        tdelete :article_notes
        delete :references
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
