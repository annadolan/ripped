require 'rails_helper'

describe 'GET /api/v1/exercises' do
  it 'returns all exercises' do
    exercise = create(:exercise)
    exercise2 = create(:exercise)

    get "/api/v1/exercises"

    exercises_json = JSON.parse(response.body)
    exercise_json = exercises_json[0]

    expect(exercises_json).to be_an(Array)
    expect(exercises_json.count).to eq(2)

    expect(exercise_json).to be_a(Hash)
    expect(exercise_json).to have_key("id")
    expect(exercise_json).to have_key("description")
    expect(exercise_json).to have_key("content")
    expect(exercise_json).to have_key("name")
    expect(exercise_json).to have_key("solutions")

    expect(exercise_json).to_not have_key("created_at")
    expect(exercise_json).to_not have_key("updated_at")
  end
end

describe 'GET /api/v1/exercises/:id' do
  it 'returns a single exercise' do
    exercise = create(:exercise)

    get "/api/v1/exercises/#{exercise.id}"

    exercise_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(exercise_json).to be_a(Hash)
    expect(exercise_json).to have_key("id")
    expect(exercise_json).to have_key("description")
    expect(exercise_json).to have_key("content")
    expect(exercise_json).to have_key("name")
    expect(exercise_json).to have_key("solutions")

    expect(exercise_json).to_not have_key("created_at")
    expect(exercise_json).to_not have_key("updated_at")
  end

  it 'includes solutions to the exercise' do
    exercise = create(:exercise)
    solution = create(:solution, exercise: exercise)

    get "/api/v1/exercises/#{exercise.id}"

    exercise_json = JSON.parse(response.body)
    solutions_json = exercise_json["solutions"]
    solution_json = solutions_json[0]

    expect(response).to be_success
    expect(exercise_json).to be_a(Hash)
    expect(solutions_json).to be_an(Array)

    expect(solution_json).to be_a(Hash)
    expect(solution_json).to have_key("id")
    expect(solution_json).to have_key("content")
    expect(solution_json).to have_key("exercise_id")

    expect(solution_json).to_not have_key("created_at")
    expect(solution_json).to_not have_key("updated_at")
  end

  it "returns a 400 response when exercise does not exist" do
    get "/api/v1/exercises/1"

    expect(response.status).to eq(400)
    expect(response.body).to eq("")
  end
end
