workers 1
threads_count = 5
threads threads_count, threads_count

prune_bunder

worker_timeout 300
rackup DefaultRackup
port 8082
environment ENV["RAILS_ENV"]
