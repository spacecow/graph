require 'rails_helper'
require 'vcr_helper'

describe 'Show article' do

  #mentions does not seem to be implemented yet
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
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        event = create :event, universe_id:universe.id, title:"The Standoff"
        create :participation, event_id:event.id, participant_id:article.id
        tag = tcreate :tag,
          title:'hero', tagable_id:note.id, tagable_type:'Note', universe_id:universe.id
        tcreate :tag,
          title:'Allomancy', universe_id:universe.id,
          tagable_id:article.id, tagable_type:'Article'
        citation_target = create :article, name:"a citation target",
          universe_id:universe.id
        tcreate :citation, origin_id:article.id, content:"some citation",
          target_id:citation_target.id
        citation_origin = create :article, name:"a citation origin",
          universe_id:universe.id
        tcreate :citation, target_id:article.id, content:"citerad",
          origin_id:citation_origin.id
        mention_event = tcreate :event, title:"Blue wedding"
        tcreate :article_mention, origin_id:mention_event.id,
          target_id:article.id, content:"all blue"
        visit article_path article.id
        expect(current_path).to eq article_path(article.id)
        expect(page).to have_content "Kelsier"
        expect(page).to have_content "a note"
        expect(page).to have_content "hero"
        expect(page).to have_content "Allomancy"
        expect(page.find('.citations.direct')).to have_content "some citation"
        expect(page.find('.citations.direct')).to have_content "a citation target"
        expect(page.find('.citations.inverse')).to have_content "citerad"
        expect(page.find('.citations.inverse')).to have_content "a citation origin"
        expect(page.find('.relations.list')).to have_content "Owns"
        expect(page.find('.relations.list')).to have_content "Sword"
        expect(page.find('.relations.list')).to have_content "very sharp"
        expect(page.all('.events.list').first).to have_content "The Standoff"
        #expect(page.find('.mentions.events.list')).to have_content "Blue wedding"
        #expect(page.find('.mentions.events.list')).to have_content "all blue"
      ensure
        tdelete :article_mentions
        tdelete :citations
        tdelete :article_notes
        tdelete :participations
        delete :relations
        tdelete :tags
        delete :notes
        tdelete :events
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to a relative page" do
    VCR.use_cassette('navigate_to_tag_represented_by_article') do
      begin
        universe = create :universe, title:'The Final Empire'
        visit universes_path
        click_link "The Final Empire"
        article = create :article, universe_id:universe.id
        tcreate :tag,
          title:'Allomancy', universe_id:universe.id,
          tagable_id:article.id, tagable_type:'Article'
        article2 = create :article, universe_id:universe.id, name:"Allomancy"
        visit article_path article.id
        within('li.tag'){ click_link "Allomancy" }
        expect(current_path).to eq article_path(article2.id) 
      ensure
        tdelete :tags
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
        note = tcreate :note
        tcreate :article_note, article_id:article.id, note_id:note.id
        tag = tcreate :tag,
          title:'hero', tagable_id:note.id, tagable_type:'Note', universe_id:universe.id
        visit article_path article.id
        expect(page).to have_content 'hero'
        click_link 'hero'
        expect(current_path).to eq tag_path(tag.id)
      ensure
        tdelete :article_notes
        tdelete :tags
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
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        visit article_path article.id
        click_link 'a note'
        expect(current_path).to eq note_path(note.id)
      ensure
        tdelete :article_notes
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
        note = tcreate :note, text:'a note'
        tcreate :article_note, article_id:article.id, note_id:note.id
        visit article_path article.id
        within('li.note'){ click_link "Edit" }
        expect(current_path).to eq edit_note_path(note.id)
      ensure
        tdelete :article_notes
        delete :notes
        delete :articles
        tdelete :universes
      end
    end
  end

  it "invert a relation" do
    VCR.use_cassette("invert_a_relation") do
      begin
        universe = create :universe, title:'The Final Empire'
        article = create :article, universe_id:universe.id
        target = create :article, universe_id:universe.id
        create :relation, origin_id:article.id, target_id:target.id, type:'Owner'
        visit universes_path
        click_link "The Final Empire"
        visit article_path article.id
        expect(page.find '.relations.list').to have_content 'Owner'
        click_link 'Invert'
        expect(page.find '.relations.list').to have_content 'Owns'
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

  it "navigate to an edit relation page" do
    VCR.use_cassette('navigate_to_an_edit_relation_page') do
      begin
        universe = create :universe, title:'The Drowned World'
        article = create :article, universe_id:universe.id
        target = create :article, universe_id:universe.id
        relation = create :relation, origin_id:article.id, target_id:target.id
        visit universes_path
        click_link "The Drowned World"
        visit article_path article.id
        within('.relations.list'){ click_link 'Edit' }
        expect(current_path).to eq edit_relation_path(relation.id)
      ensure
        delete :relations
        delete :articles
        tdelete :universes
      end
    end
  end

end
