# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161011073340) do

  create_table "activities", force: :cascade do |t|
    t.datetime "first_phase_begin"
    t.datetime "second_phase_begin"
    t.datetime "third_phase_begin"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.text     "thought_morals"
    t.text     "upright_incorruptiable"
    t.text     "duties"
    t.string   "user_type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "evaluation_totality"
    t.string   "evaluationable_type"
    t.integer  "evaluationable_id"
    t.string   "create_year"
    t.index ["evaluationable_type", "evaluationable_id"], name: "index_evaluations_on_evaluationable_type_and_evaluationable_id"
    t.index ["user_type"], name: "index_evaluations_on_user_type_and_user_id"
  end

  create_table "self_evaluations", force: :cascade do |t|
    t.string   "duties"
    t.string   "self_evaluation_totality"
    t.integer  "middle_manager_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "create_year"
    t.index ["middle_manager_id"], name: "index_self_evaluations_on_middle_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "job_num"
    t.text     "user_info"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
