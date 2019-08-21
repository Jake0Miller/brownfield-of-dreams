require 'rails_helper'

describe GithubService do
  it "exists" do
    github_service = GithubService.new

    expect(github_service).to be_a(GithubService)
  end

  context "instance methods" do
    context "#repository_data" do
      it "returns repositories", :vcr do
        search = subject.repository_data
        expect(search).to be_a Array
        expect(search.count).to eq 30
        expect(search[0]).to be_an Hash
        member_data = search[0]

        expect(member_data).to have_key :name
      end
    end

    context "#follower_data" do
      it "returns followers", :vcr do
        search = subject.follower_data
        expect(search).to be_a Array
        expect(search.count).to eq 3
        expect(search[0]).to be_an Hash
        follower_data = search[0]

        expect(follower_data).to have_key :login
      end
    end

		context "#follower_data" do
			it "returns following", :vcr do
				search = subject.following_data
				expect(search).to be_an Array
				expect(search.count).to eq 3
				expect(search[0]).to be_a Hash
				following_data = search[0]

				expect(following_data).to have_key :login
			end
		end
  end
end
