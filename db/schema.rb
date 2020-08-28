# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_21_064444) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "educations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "college"
    t.string "major"
    t.date "date_from"
    t.date "date_to"
    t.text "certification"
    t.text "additional_information"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_educations_on_profile_id"
  end

  create_table "experiences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "company_name"
    t.string "job_position"
    t.date "date_from"
    t.date "date_to"
    t.text "additional_information"
    t.bigint "profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_experiences_on_profile_id"
  end

  create_table "job_applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "recruiter_id"
    t.bigint "job_post_id", null: false
    t.string "status", default: "reviewing"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_job_applications_on_candidate_id"
    t.index ["job_post_id"], name: "index_job_applications_on_job_post_id"
    t.index ["recruiter_id"], name: "index_job_applications_on_recruiter_id"
  end

  create_table "job_posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.integer "salary_from"
    t.integer "salary_to"
    t.string "note"
    t.bigint "category_id", null: false
    t.bigint "user_id", null: false
    t.bigint "unit_id", null: false
    t.text "description"
    t.text "requirement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_job_posts_on_category_id"
    t.index ["unit_id"], name: "index_job_posts_on_unit_id"
    t.index ["user_id", "created_at"], name: "index_job_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_job_posts_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.text "message"
    t.bigint "job_post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_post_id"], name: "index_notifications_on_job_post_id"
    t.index ["receiver_id"], name: "index_notifications_on_receiver_id"
    t.index ["sender_id"], name: "index_notifications_on_sender_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "introduction"
    t.date "date_of_birth"
    t.text "address"
    t.string "phone_number"
    t.bigint "user_id", null: false
    t.integer "gender", default: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "phone_number"
    t.text "overview"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "roles", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.bigint "unit_id"
    t.index ["unit_id"], name: "index_users_on_unit_id"
  end

  add_foreign_key "educations", "profiles"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "job_applications", "job_posts"
  add_foreign_key "job_applications", "users", column: "candidate_id"
  add_foreign_key "job_applications", "users", column: "recruiter_id"
  add_foreign_key "job_posts", "categories"
  add_foreign_key "job_posts", "units"
  add_foreign_key "job_posts", "users"
  add_foreign_key "notifications", "job_posts"
  add_foreign_key "notifications", "users", column: "receiver_id"
  add_foreign_key "notifications", "users", column: "sender_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "units"
end
