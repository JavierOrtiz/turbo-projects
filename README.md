# Welcome to TurboProjects! 🚀

Just ensure you have Ruby installed.

1. Clone the repo and execute `bundle install` and `yarn install`
2. Execute `rails db:prepare`
3. Execute `bin/rails mission_control:jobs:authentication:configure` to get the credentials to access the Jobs Dashboard.
4. You are ready, just execute `./bin/dev`

If you want to test the job to handle the Task expirations, follow the next steps:
1. Access to `http:localhost:3000/jobs`
2. Go to `Recurring Tasks`
3. Click `Run now` on `a_check_task_expirations` task