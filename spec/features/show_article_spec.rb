require 'rails_helper'
require 'vcr_helper'

describe 'Show article' do

  it "displays the article with its notes & tags" do
    VCR.use_cassette("display_article_with_notes") do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        pistol = create :article, name:"Pistol", universe_id:universe.id
        sword = create :article, name:"Sword", universe_id:universe.id
        article = create :article, name:'Kelsier',
          universe_id:universe.id, type:'Character'
        relation = create :relation, origin_id:sword.id,
          target_id:article.id, type:"Owner"
        create :relation, origin_id:pistol.id, target_id:article.id, type:"Owner"
        create :reference, referenceable_id:relation.id,
          referenceable_type:"Relation", comment:"very sharp"
        note = create :note, article_id:article.id, text:'a note'
        tag = create :tag, title:'hero'
        event = create :event, universe_id:universe.id, title:"The Standoff"
        create :participation, event_id:event.id, article_id:article.id
        create :tagging, tag_id:tag.id, tagable_id:note.id, tagable_type:'Note'
        visit article_path article.id
        expect(current_path).to eq article_path(article.id)
        expect(page).to have_content "Kelsier"
        expect(page).to have_content "a note"
        expect(page).to have_content "hero"
        expect(page.find('.relations.list')).to have_content "Owns"
        expect(page.find('.relations.list')).to have_content "Sword"
        expect(page.find('.relations.list')).to have_content "very sharp"
        expect(page.find('.events.list')).to have_content "The Standoff"
      ensure
        delete :participations
        delete :relations
        delete :taggings
        delete :tags
        delete :notes
        tdelete :events
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to a relative page" do
    VCR.use_cassette('navigate_to_a_relative_page') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        article = create :article, universe_id:universe.id
        sword = create :article, universe_id:universe.id, name:"Sword"
        relation = create :relation, origin_id:sword.id, target_id:article.id
        visit article_path article.id
        click_link "Sword"
        expect(current_path).to eq article_path(sword.id)
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to a relation page" do
    VCR.use_cassette('navigate_to_a_relation_page') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        article = create :article, universe_id:universe.id
        sword = create :article, universe_id:universe.id
        relation = create :relation, origin_id:sword.id, target_id:article.id, type:"Owner"
        visit article_path article.id
        click_link 'Owns'
        expect(current_path).to eq relation_path(relation.id)
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to a tag page" do
    VCR.use_cassette('navigate_to_a_tag_page') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        article = create :article, universe_id:universe.id
        note = create :note, article_id:article.id
        tag = create :tag, title:'hero'
        create :tagging, tag_id:tag.id, tagable_id:note.id, tagable_type:'Note'
        visit article_path article.id
        expect(page).to have_content 'hero'
        click_link 'hero'
        expect(current_path).to eq tag_path(tag.id)
      ensure
        delete :taggings
        delete :tags
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to a note page" do
    VCR.use_cassette('navigate_to_a_note_page') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        article = create :article, name:'Kelsier', universe_id:universe.id, type:'Character'
        note = create :note, article_id:article.id, text:'a note'
        visit article_path article.id
        click_link 'a note'
        expect(current_path).to eq note_path(note.id)
      ensure
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to an edit note page" do
    VCR.use_cassette('navigate_to_an_edit_note_page') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        article = create :article, name:'Kelsier', universe_id:universe.id, type:'Character'
        note = create :note, article_id:article.id, text:'a note'
        visit article_path article.id
        within('li.note'){ click_link "Edit" }
        expect(current_path).to eq edit_note_path(note.id)
      ensure
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

end
