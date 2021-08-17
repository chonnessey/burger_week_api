# spec/requests/reviews_spec.rb
require 'rails_helper'

RSpec.describe 'Reviews API' do
  # Initialize the test data
  let!(:burger) { FactoryBot.create(:burger) }
  let!(:reviews) { FactoryBot.create_list(:review, 20, burger_id: burger.id) }
  let(:burger_id) { burger.id }
  let(:id) { reviews.first.id }

  # Test suite for GET /burgers/:burger_id/reviews
  describe 'GET /burgers/:burger_id/reviews' do
    before { get "/burgers/#{burger_id}/reviews" }

    context 'when burger exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all burger reviews' do
        expect(JSON.parse(response.body).size).to eq(20)
      end
    end

    context 'when burger does not exist' do
      let(:burger_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body).fetch("message")).to match("Couldn't find Burger with")
      end
    end
  end

  # Test suite for GET /burgers/:burger_id/reviews/:id
  describe 'GET /burgers/:burger_id/reviews/:id' do
    before { get "/burgers/#{burger_id}/reviews/#{id}" }

    context 'when burger review exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the review' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when burger review does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  # Test suite for POST /burgers/:burger_id/reviews
  describe 'POST /burgers/:burger_id/reviews' do
    let(:valid_attributes) { { author: 'Mozart', content: 'content', rating: 5 } }

    context 'when request attributes are valid' do
      before { post "/burgers/#{burger_id}/reviews", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/burgers/#{burger_id}/reviews", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Author can't be blank/)
      end
    end
  end

  # Test suite for PUT /burgers/:burger_id/reviews/:id
  describe 'PUT /burgers/:burger_id/reviews/:id' do
    let(:valid_attributes) { { author: 'Mozart', content: 'content', rating: 5 } }

    before { put "/burgers/#{burger_id}/reviews/#{id}", params: valid_attributes }

    context 'when review exists' do
      it 'returns success message' do
        expect(response.body).to match('This review has been updated successfully.')
      end

      it 'updates the review' do
        updated_review = Review.find(id)
        expect(updated_review.author).to match(/Mozart/)
      end
    end

    context 'when the review does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  # Test suite for DELETE /burgers/:id
  describe 'DELETE /burgers/:id' do
    before { delete "/burgers/#{burger_id}/reviews/#{id}" }

    it 'returns success message' do
      expect(response.body).to match('This review has been deleted successfully.')
    end
  end
end