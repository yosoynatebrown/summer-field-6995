require "rails_helper"

RSpec.describe 'Studio index page' do
  before(:each) do
    @universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @disney = Studio.create!(name: 'Disney', location: 'Fort Lauderdale')

    @ark = @universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @shrek = @universal.movies.create!(title: 'Shrek', creation_year: 2000, genre: 'Comedy')

    @matrix = @disney.movies.create!(title: 'The Matrix', creation_year: 1999, genre: 'Action/Adventure')
    @star_wars = @disney.movies.create!(title: 'Star Wars', creation_year: 1978, genre: 'Sci-Fi')

    visit '/studios'
  end

  it "has the studio's name and location" do
    expect(page).to have_content(@universal.name)
    expect(page).to have_content(@universal.location)

    expect(page).to have_content(@disney.name)
    expect(page).to have_content(@disney.location)
  end

  it "has the titles of all movies the studio produced" do
    within "#studio-#{@universal.id}" do
      expect(page).to have_content(@ark.title)
      expect(page).to have_content(@shrek.title)
    end

    within "#studio-#{@disney.id}" do
      expect(page).to have_content(@matrix.title)
      expect(page).to have_content(@star_wars.title)
    end
  end
end
