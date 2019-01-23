require "spec_helper"

RSpec.describe "POST /ratingQuestions" do
  let(:new_title) { "Hello World" }

  context "when the request has a body" do
    let(:response) { HTTP.post("#{SERVER}/ratingQuestions", json: { title: new_title }) }

    it "returns a 201 Created" do
      expect(response.status).to eq(201)
    end

    it "returns the new document" do
      question = response.parse
      expect(question.is_a?(Hash)).to eq(true)
      expect(question.key?("id")).to eq(true)
      expect(question["title"]).to eq(new_title)
    end
  end

  context "when the request has no body" do
    let(:response) { HTTP.post("#{SERVER}/ratingQuestions") }

    it "returns a 422 Invalid Resource" do
      expect(response.status).to eq(422)
    end

    it "has no title attribute" do
      error = response.parse
      expect(error).to eq({"errors" => [{"title" => "cannot be blank"}]})
    end
  end
end
