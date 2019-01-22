require "spec_helper"

RSpec.describe "PUT /ratingQuestions/:id" do
  context "when the question exists" do
    let(:question) do
      response = HTTP.post("#{SERVER}/ratingQuestions", json: { title: "Hello World" })
      response.parse
    end

    let(:response) { HTTP.put("#{SERVER}/ratingQuestions/#{question["id"]}", json: { not_title: "Hello Mars" })}

    it "returns a 200 OK" do
      expect(response.status).to eq(200)
    end

    it "updates the whole question, removing the old question" do
      question = response.parse
      expect(question.is_a?(Hash)).to eq(true)
      expect(question["not_title"]).to eq("Hello Mars")
    end
  end

  context "asking to get a question that doesn't exist" do
    let(:response) do
      HTTP.put("#{SERVER}/ratingQuestions/i-will-never-exist")
    end

    it "returns a 404 Not Found" do
      expect(response.status).to eq(404)
    end
  end
end
