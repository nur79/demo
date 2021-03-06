require 'spec_helper'

describe "Micropost pages" do

	subject { page }
	let(:user) { FactoryGirl.create(:user) } 
	before { sign_in user }

	describe "micropost creation" do 

		before { visit root_path }

		describe "with invalid information" do

			it "should not create a micropost" do 
				expect { click_button "Post" }.should_not change(Micropost, :count)
			end 

			describe "error messages" do 

				before { click_button "Post" } 

				it { should have_content('error') }
			end 
		end 

		describe "with valid information" do

			before { fill_in 'micropost_content', with: "Lorem ipsum" } 

			it "should create a micropost" do

				expect { click_button "Post" }.should change(Micropost, :count).by(1) 
			end 
		end 
	end

	describe "micropost destruction" do

		let!(:micpost) { FactoryGirl.create(:micropost, user: user) }

		describe "as incorrect user" do

			let!(:another_user) { FactoryGirl.create(:user) }
			before do 
				sign_out
				sign_in another_user
			end

			it "should not delete a micropost of other" do 
				expect { delete micropost_path(micpost) }.should_not change(Micropost, :count).by(-1)
			end 
		end 

		describe "as correct user" do

			before { visit root_path }

			it "should delete a micropost" do 
				expect { click_link "delete" }.should change(Micropost, :count).by(-1)
			end 
		end 
	end
end