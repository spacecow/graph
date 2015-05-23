require 'active_model'
require './app/models/article'
require './app/models/universe'
require 'rspec/its'

describe Universe do

  context 'universe with associated articles' do

    let(:params){{
      title:'The Final Empire',
      articles:[{name:'Kelsier'}] }}
    let(:universe){ Universe.new params }
    let(:article){ universe.articles.first }

    describe "the universe's first article" do
      subject{ universe.articles.first }
      its(:class){ is_expected.to be Article }
    end

    describe "the article's universe" do
      subject{ article.universe }
      it{ is_expected.to be universe }
    end

  end
end
