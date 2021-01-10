# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_10_213136) do

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exercises_workouts", id: false, force: :cascade do |t|
    t.integer "workout_id", null: false
    t.integer "exercise_id", null: false
    t.index ["workout_id", "exercise_id"], name: "index_exercises_workouts_on_workout_id_and_exercise_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "trainee_workouts", force: :cascade do |t|
    t.integer "trainer_id", null: false
    t.integer "trainee_id", null: false
    t.integer "workout_id", null: false
    t.string "state"
    t.integer "current_exercise_id"
    t.integer "medium_pulse"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trainee_id"], name: "index_trainee_workouts_on_trainee_id"
    t.index ["trainer_id"], name: "index_trainee_workouts_on_trainer_id"
    t.index ["workout_id"], name: "index_trainee_workouts_on_workout_id"
  end

  create_table "trainees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_trainees_on_email", unique: true
  end

  create_table "trainer_selections", force: :cascade do |t|
    t.integer "trainee_id", null: false
    t.integer "trainer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trainee_id"], name: "index_trainer_selections_on_trainee_id"
    t.index ["trainer_id"], name: "index_trainer_selections_on_trainer_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "password_digest"
    t.index ["email"], name: "index_trainers_on_email", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.integer "creator_id", null: false
    t.integer "total_duration"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_workouts_on_creator_id"
    t.index ["state"], name: "index_workouts_on_state"
  end

  add_foreign_key "taggings", "tags"
  add_foreign_key "trainee_workouts", "trainees"
  add_foreign_key "trainee_workouts", "trainers"
  add_foreign_key "trainee_workouts", "workouts"
  add_foreign_key "trainer_selections", "trainees"
  add_foreign_key "trainer_selections", "trainers"
end
