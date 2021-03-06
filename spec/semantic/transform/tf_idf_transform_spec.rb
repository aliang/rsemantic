require File.dirname(__FILE__) + '/../../spec_helper'

module Semantic
  describe Transform::TFIDF do

    def matrix(matrix)
      Linalg::DMatrix.rows(matrix)
    end

    tiny_matrix = Linalg::DMatrix.rows([[0.0, 1.0, 0.0],
    [1.0, 0.0, 1.0]])

    describe "term frequency / inverse document frequency transform" do

      it "should find the number of times each term occurs" do
        Transform::TFIDF.should_receive(:number_of_documents_with_term).with(0, matrix([[1]])).and_return(2)

        Transform::TFIDF.transform(matrix([[1]]))
      end

      it "should ignore counting terms with 0 weighting" do
        Transform::TFIDF.should_not_receive(:number_of_documents_with_term)

        Transform::TFIDF.transform(matrix([[0,0],[0,0]]))
      end

      it "should calculate term frequency * inverse document freuency" do
        transformed_matrix = Transform::TFIDF.transform matrix([[1,1],[0,1]])

        transformed_matrix.to_s.should == Linalg::DMatrix.columns([[0, 0],[0, 0.346574]]).to_s
      end

    end
  end
end
