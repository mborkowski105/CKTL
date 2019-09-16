# Module One Final Project Guidelines

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, we'll be building a Command Line database application.

## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

  **Resource:** [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.

### Brainstorming and Proposing a Project Idea

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above.  You must have a minimum of four [user stories](https://en.wikipedia.org/wiki/User_story) to help explain how a user will interact with your app.  A user story should follow the general structure of `"As a <role>, I want <goal/desire> so that <benefit>"`. In example, if we were creating an app to randomly choose nearby restaurants on Yelp, we might write:

* As a user, I want to be able to enter my name to retrieve my records
* As a user, I want to enter a location and be given a random nearby restaurant suggestion
* As a user, I should be able to reject a suggestion and not see that restaurant suggestion again
* As a user, I want to be able to save to and retrieve a list of favorite restaurant suggestions

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributors guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Be prepared to present your project to your peers (3 - 5 minutes) 
  * _See below for instructions_
6. *OPTIONAL* Prepare a video demo (narration helps!) describing how a user would interact with your working project.
7. *OPTIONAL*: Write a blog post about the project and process.

## Short Presentation Requirements

Presenting to others on a technical topic is something you will do several times throughout your experience at Flatiron. This will allow you to practice exercising some important skills. 

#### Introducing Yourself
At the beginning of your presentation you'll want to introduce yourself to the audience. Even if you already know your peers and this feels awkward, this is great & low-stakes way to practice for your personal elevator pitch in a welcoming space. Take it seriously and be kind to others; maybe you'll learn something new about someone!

Aim for a short, 30-second summary of your career progression, leading up to Flatiron School, with an emphasis on your professional skills and goals. Think of it as a condensed narration of your story; where you started, what inspired you to get into coding (did you have a pivotal "aha!" moment?), what you're passionate about, and what you're looking forward to going forward (job and/or career wise).

Here are two examples as inspiration:

> Hi, my name is Pam and building and creating things have always been in my blood. It started when I used to make model airplanes in the 5th grade, and continued through college, during which I took a few computer science classes. After graduating with a environmental sustainability degree I worked at hazardous waste and solar energy companies. It wasn't long before I realized that my creative spirit had been stifled and was aching to escape...and that coding was what truly made me come alive! I'm now thrilled to be here at Flatiron and soon launching my new career in software engineering!

> Hi, my name is Tony and I'm a former educator with a Bachelor and Masters in English and Professional Studies from Stony Brook. I've held roles as a teacher, academic policy programmer, and dean of students at two NYC public high schools. I've always loved puzzles and solving problems, and I see coding as an extension of this. I'm excited to merge my previous background in education with my new found programming skills to launch a new career as a developer in the ed tech space.

There's no right or wrong way to introduce yourself. It's your story, so make it your own. :)

#### Technical Presentation Requirements
Having built your project on your own with a partner, you are the expert on it! Even though that's the case, talking about techincal topics can be challenging. Do your best to communicate what you have learned in a way others can digest.
  - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
  - Discuss 3 things you learned in the process of working on this project.
  - Address, if anything, what you would change or add to what you have today?
  - Present any code you would like to highlight.   
  - Be prepared to answer questions from your peers!

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
```
