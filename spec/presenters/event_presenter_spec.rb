require 'active_support/core_ext/object/try'
require './app/presenters/base_presenter'
require './app/presenters/event_presenter'

describe EventPresenter do

  let(:presenter){ EventPresenter.new event, view }
  let(:event){ double :event }
  let(:view){ :view }

  subject{ presenter.send function }

end
