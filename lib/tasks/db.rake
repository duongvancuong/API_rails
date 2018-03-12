namespace :db do
  desc "Re-Create database, db:drop, db:create, db:migrate"
  task recreate: ["db:drop", "db:create", "db:migrate", "db:seed"]
end
