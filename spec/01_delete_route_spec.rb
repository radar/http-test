require "spec_helper"

RSpec.describe "DELETE /ratingQuestions/:id" do
  context "with an existing question" do
    let(:question) do
      response = HTTP.post("#{SERVER}/ratingQuestions", json: { title: "Hello World" })
      response.parse
    end

    let(:response) do
      HTTP.delete("#{SERVER}/ratingQuestions/#{question["id"]}")
    end

    it "returns a 204 No Content" do
      expect(response.status).to eq(204)
    end

    it "returns nothing" do
      expect(response.parse).to eq({})
    end
  end

  context "asking to delete a question that doesn't exist" do
    let(:response) do
      HTTP.delete("#{SERVER}/ratingQuestions/i-will-never-exist")
    end

    it "returns a 404 Not Found" do
      expect(response.status).to eq(404)
    end
  end
end
