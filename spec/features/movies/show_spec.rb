require "rails_helper"

RSpec.describe 'Movies show page' do
  before(:each) do
    @universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')

    @ark = @universal.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @punch = @universal.movies.create!(title: 'Punch Drunk Love', creation_year: 2007, genre: 'Romance')


    @ford = @ark.actors.create!(name: 'Harrison Ford', age: 35)
    @keanu = @ark.actors.create!(name: 'Keanu Reeves', age: 18)
    @jamie = @ark.actors.create!(name: 'Jamie Lee Curtis', age: 17)

    @adam = @punch.actors.create!(name: 'Adam Sandler', age: 40)

    visit "/movies/#{@ark.id}"
  end

  it "should have the title, creation year, and genre" do
    expect(page).to have_content(@ark.title)
    expect(page).to have_content(@ark.creation_year)
    expect(page).to have_content(@ark.genre)
  end

  it "should list all actors from youngest to oldest" do
    expect(page.text.index(@ford.name)).to be > page.text.index(@keanu.name)
    expect(page.text.index(@keanu.name)).to be > page.text.index(@jamie.name)
  end

  it "should list actors' average age" do
    expect(page).to have_content(@ark.actors.average_age)
  end

  it "shouldn't have actors from a different movie" do
    expect(page).not_to have_content(@adam.name)
  end
  describe "form to add an actor" do
    context "when actor exists" do
      it "should add an actor" do
        fill_in 'Name', with: 'Adam Sandler'
        click_button 'Submit'

        expect(current_path).to eq("/movies/#{@ark.id}")
        expect(page).to have_content(@adam.name)
      end
    end
    context "when actor doesn't exist in database" do
      it "redirects to movie show page without adding actor" do
        fill_in 'Name', with: 'Nate Brown'
        click_button 'Submit'

        expect(current_path).to eq("/movies/#{@ark.id}")
        expect(page).not_to have_content("Nate Brown")
      end
    end
  end
end
