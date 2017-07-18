require 'rails_helper'
require 'spec_helper'

describe MoviesController, :type => :controller do
    describe "find movies with same director" do
        it "should call the model method that finds movies with same director" do
            expect(Movie).to receive(:find_with_same_director).with("1")
            get :similar, {:id => 1}
        end
        
        it "should select the Similar template for rendering when movie has a director" do
            allow(Movie).to receive(:find_with_same_director).and_return(nil,nil,false)
            get :similar, {:id => 1}
            expect(response).to render_template('similar')
        end
        
        it "should make the movies with same director available to that template" do
            fake_movie = double('Movie')
            fake_results = [double('Movie'), double('Movie')]
            allow(Movie).to receive(:find_with_same_director).and_return([fake_movie, fake_results, false])
            get :similar, {:id => 1}
            expect(assigns(:movie)).to eq fake_movie
            expect(assigns(:movies)).to eq fake_results
        end
        
        it "should select the Index page to redirect to when movie has no director" do
            fake_movie = double('Movie', :title => 'Aladdin')      
            allow(Movie).to receive(:find_with_same_director).and_return([fake_movie,nil,true])            
            get :similar, {:id => 1}
            expect(response).to redirect_to(movies_path)
        end
        
        it "should make the error message available to that template" do
            fake_movie = double('Movie', :title => 'Aladdin')
            allow(Movie).to receive(:find_with_same_director).and_return([fake_movie,nil,true])
            get :similar, {:id => 1}
            expect(flash[:notice]).to eq("'#{fake_movie.title}' has no director info")
        end
    end

    
    describe "create a new movie" do
        it "should call the model method that find movie by ID" do
            allow(Movie).to receive(:create)
            post :new
        end
    end
    describe "show a movie" do
        it "should call the model method that find movie by ID" do
            expect(Movie).to receive(:find).with("1")
            get :show, {:id => 1}
        end
    end
    describe "update a movie" do
        it "should call the model method that find movie by ID" do
            expect(Movie).to receive(:find).with("1")
            get :edit, {:id => 1}
        end
    end
    describe "destroy a movie" do
        it "should call the model method that find movie by ID" do
            expect(Movie).to receive(:find).with("1")
            get :show, {:id => 1}
        end
    end
end