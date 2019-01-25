require "spec_helper"

RSpec.describe "POST /ratingQuestions" do
  let(:new_title) { "Hello World" }
  let(:new_tag) { "new tag" }

  context "when the request has a body" do
    let(:response) { HTTP.post("#{SERVER}/ratingQuestions", json: { title: new_title, tag: new_tag }) }

    it "returns a 201 Created" do
      expect(response.status).to eq(201)
    end

    it "returns the new document" do
      question = response.parse
      expect(question.is_a?(Hash)).to eq(true)
      expect(question.key?("id")).to eq(true)
      expect(question["title"]).to eq(new_title)
      expect(question["tag"]).to eq(new_tag)
    end
  end

  context "when the request has no body" do
    let(:response) { HTTP.post("#{SERVER}/ratingQuestions") }

    it "returns a 400 Bad Request" do
      expect(response.status).to eq(400)
    end
  end

  context "when the request has a blank title" do
    let(:response) { HTTP.post("#{SERVER}/ratingQuestions", json: { title: "" }) }

    it "returns a 422 Invalid Resource" do
      expect(response.status).to eq(422)
    end

    it "shows errors that the title cannot be blank" do
      error = response.parse
      expect(error).to eq({"errors" => {"title" => ["cannot be blank"]}})
    end
  end
end
