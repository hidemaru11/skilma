class HomeController < ApplicationController
  def index
    @skill = Skill.last
    @mate = Mate.last
    @job = Job.last
  end
end
