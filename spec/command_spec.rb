# frozen_string_literal: true
require "spec_helper"
require "robot"

RSpec.describe Robot do

  context "with PLACE command" do

    robot = Robot::Robot.new

    it "saves the position" do
      robot.place 1, 2, :north
      expect(robot.position.x).to eq 1
      expect(robot.position.y).to eq 2
      robot.place 3, 4, :south
      expect(robot.position.x).to eq 3
      expect(robot.position.y).to eq 4
    end

    it "saves the direction" do
      robot.place 1, 2, :north
      expect(robot.direction).to eq :north
      robot.place 3, 4, :south
      expect(robot.direction).to eq :south
    end

    it "must have a valid direction" do
      expect { robot.place 0, 0, :hubwards }.to raise_error(ArgumentError)
    end

  end

  context "with MOVE command" do

    it "has no effect before PLACE" do
      robot = Robot::Robot.new
      robot.move
      expect(robot.position).to be_nil
    end

    it "moves north" do
      robot = Robot::Robot.new
      robot.place 2, 2, :north
      robot.move
      expect(robot.position.x).to eq 2
      expect(robot.position.y).to eq 3
      expect(robot.direction).to eq :north
    end

    it "moves south" do
      robot = Robot::Robot.new
      robot.place 2, 2, :south
      robot.move
      expect(robot.position.x).to eq 2
      expect(robot.position.y).to eq 1
      expect(robot.direction).to eq :south
    end

    it "moves east" do
      robot = Robot::Robot.new
      robot.place 2, 2, :east
      robot.move
      expect(robot.position.x).to eq 3
      expect(robot.position.y).to eq 2
      expect(robot.direction).to eq :east
    end

    it "moves west" do
      robot = Robot::Robot.new
      robot.place 2, 2, :west
      robot.move
      expect(robot.position.x).to eq 1
      expect(robot.position.y).to eq 2
      expect(robot.direction).to eq :west
    end

  end

  context "with LEFT and RIGHT commands" do

    it "has no effect before PLACE" do
      robot = Robot::Robot.new
      robot.left
      expect(robot.direction).to be_nil
      robot = Robot::Robot.new
      robot.right
      expect(robot.direction).to be_nil
    end

    it "turns left" do
      robot = Robot::Robot.new
      robot.place 2, 2, :north
      [:west, :south, :east, :north].each do |direction|
        robot.left
        expect(robot.direction).to eq direction
      end
    end

    it "turns right" do
      robot = Robot::Robot.new
      robot.place 2, 2, :north
      [:east, :south, :west, :north].each do |direction|
        robot.right
        expect(robot.direction).to eq direction
      end
    end

  end

end
