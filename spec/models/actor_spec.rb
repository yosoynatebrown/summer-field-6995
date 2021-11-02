require "rails_helper"

RSpec.describe Actor, type: :model do
  describe "relationships" do
    it { should have_many :actor_movies}
    it { should have_many(:movies).through(:actor_movies)}
  end
  before(:each) do
    @universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')

    @ark = @universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @shrek = @universal.movies.create!(title: 'Shrek', creation_year: 2000, genre: 'Comedy')


    @ford = @ark.actors.create!(name: 'Harrison Ford', age: 35)
    @keanu = @ark.actors.create!(name: 'Keanu Reeves', age: 18)
    @jamie = @ark.actors.create!(name: 'Jamie Lee Curtis', age: 17)

    @mike = @shrek.actors.create!(name: 'Mike Myers', age: 37)
  end

  describe '#order_by_age' do
    it 'should provide actors in order of age (ascending)' do
      expect(Actor.order_by_age).to eq([@jamie, @keanu, @ford, @mike])
    end
  end

  describe '#average_age' do
    it 'should provide average age of actors' do
      expect(Actor.average_age).to eq(26.75)
    end
  end

  describe '#coactors' do
    it 'should provide actors a particular actor has worked with' do
      expect(@ford.coactors).to include(@keanu, @jamie)
      expect(@ford.coactors).not_to include(@mike)
      expect(@ford.coactors).not_to include(@ford)
    end
  end
end
