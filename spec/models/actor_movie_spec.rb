require 'rails_helper'

RSpec.describe ActorMovie, type: :model do
  describe "relationships" do
    it { should belong_to :actor }
    it { should belong_to :movie }
  end
end
