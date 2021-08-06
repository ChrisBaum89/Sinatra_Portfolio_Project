# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database - my models inherit ActiveRecord::Base
- [x] Include more than one model class (e.g. User, Post, Category) - I have 4 models (bait, catch, fish, user)
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - Bait model has_many Catches and Users have_many Baits
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - Bait belongs_to a User, Fish belongs_to Catches.
- [x] Include user accounts with unique login attribute (username or email) - signup requires username, email, password.  Sign-in requires existing username and password.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - Catch model and Bait model both can be created, read, updated, and destroyed.
- [x] Ensure that users can't modify content created by other users - code includes verification that user is logged in to render a page and redirects to Login page if not logged in.  Also includes functionality that only a user who owns a bait/catch can see/edit/destroy.
- [x] Include user input validations - user signup, creating new baits, creating new catches all have validations of the user input.  Also validate that a user owns specific catches and baits before allowing them to view/edit.
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits - commited often as I progressed
- [x] Your commit messages are meaningful - tried to add meaningful discriptions
- [x] You made the changes in a commit that relate to the commit message - up front I may have grouped some together but realized during the process what I was doing and starting individually commiting (lesson learned)
- [x] You don't include changes in a commit that aren't related to the commit message - as mentioned above I may have grouped some together at first, but caught my mistake and started individually selecting and submitting commits
