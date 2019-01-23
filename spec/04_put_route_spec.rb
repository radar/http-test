require "spec_helper"

RSpec.describe "PUT /ratingQuestions/:id" do
  context "when the question exists" do
    let(:question) do
      response = HTTP.post("#{SERVER}/ratingQuestions", json: { title: "Hello World", extra_field: "extra" })
      response.parse
    end

    let(:response) { HTTP.put("#{SERVER}/ratingQuestions/#{question["id"]}", json: { title: "Hello Mars" })}

    it "returns a 200 OK" do
      expect(response.status).to eq(200)
    end

    it "updates the whole question, removing the old question" do
      question = response.parse
      expect(question.is_a?(Hash)).to eq(true)
      expect(question["title"]).to eq("Hello Mars")
      expect(question.key?("extra_field")).to eq(false)
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
