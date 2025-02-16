class BoardsController < ApplicationController
  # GET /boards or /boards.json
  def index
    @boards = Board.all
  end
end
