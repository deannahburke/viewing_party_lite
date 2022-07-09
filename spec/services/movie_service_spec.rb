require 'rails_helper'

RSpec.describe MovieService do
  describe 'api endpoint' do
    it 'can retrieve data from top rated api endpoint', :vcr do
      json = MovieService.get_top_rated

      expect(json).to be_a(Array)
      expect(json[0]).to have_key(:title)
    end
    it 'can retrieve data from keyword api endpoint', :vcr do
      json = MovieService.get_by_keyword('Cats')

      expect(json).to be_a(Array)
      expect(json[0]).to have_key(:vote_average)
    end

    it 'can retrieve data from movie detail endpoint', :vcr do
      json = MovieService.get_details(238)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:title)
      expect(json).to have_key(:runtime)
    end 
  end
end
