require 'active_model'
require './app/models/article'
require './app/models/universe'
require 'rspec/its'

describe Article do

  context 'article with associated universe' do
  
    let(:params){{
      name:'Kelsier',
      universe:{title:'The Final Empire'} }}
    let(:article){ Article.new params }
    let(:universe){ article.universe }
    
    describe "the article's universe" do
      subject{ article.universe }
      its(:class){ is_expected.to be Universe }
    end

    describe "the universe's first article" do
      subject{ universe.articles.first }
      it{ is_expected.to be article }
    end
  end

end
