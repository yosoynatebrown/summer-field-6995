require "rails_helper"

RSpec.describe 'Actors show page' do
  before(:each) do
    @universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')

    @ark = @universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')

    @ford = @ark.actors.create!(name: 'Harrison Ford', age: 35)
    @keanu = @ark.actors.create!(name: 'Keanu Reeves', age: 18)
    @jamie = @ark.actors.create!(name: 'Jamie Lee Curtis', age: 17)

    visit "/actors/#{@keanu.id}"
  end

  it "should have the actor's name and age" do
    expect(page).to have_content(@keanu.name)
    expect(page).to have_content(@keanu.age)
  end

  it "should have the actor's coactors" do
    expect(page).to have_content("Coactors:")
    expect(page).to have_content(@jamie.name)
    expect(page).to have_content(@ford.name)
    expect(page).not_to have_content(@ford.age)
    expect(page).not_to have_content(@jamie.age)
  end
end
