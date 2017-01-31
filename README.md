#aNSWR

## Background

An app that allows users to pick a highly debated question among a group of friends,
post their individual answers to that question, and allow the public to vote on their favorite aNSWR.

This app was conceived from the arguments you have with your friends that can't
be settled due to immovable beliefs or opinions on a matter. MJ or LeBron?
Star Trek or Star Wars? Marvel or DC?

## Functionality & MVP

Users will be able to:
- [ ]   create User accounts with full authentication
- [ ]   create questions- either yes/no or multiple choice
- [ ]   create answers- There can be up to 5 answers per question
- [ ]   vote on answers

## Bonus

- [ ]   create comments on a question
- [ ]   Search function for questions

## Wireframes
  * [News Feed](wireframes/news_feed.png)
  * [question detail](wireframes/question_detail.png)
  * [splash](wireframes/splash.png)
  * [sign up](wireframes/sign_up.png)
  * [sign in](wireframes/sign_in.png)
  * [form](wireframes/form.png)
  * [user profile](wireframes/user_profile.png)

## Technologies & Technical Challenges
This app will be implemented using Swift and Firebase on an iOS platform.

### Group Members & Work Breakdown
Our group consists of three members, Hui, Nathan and Andrew.

Andrew's primary responsibilities will be:
- Allow user to create questions
- Create a seamless user interface for creating and viewing questions
- Questions can have many answers with the possibility of also having comments

Nathan's primary responsibilities will be:

- Handle the creation and rendering of answers to posted questions
- Ensure when a user creates a question, they have to pick at least one answer
- Ensure users can create answers to another user's question if there are less than 5
  answers and the creator has not limited the nubmer of answers
- Ensure answers have a bar graph displaying the percentage of votes
- Ensure answers are displayed neatly on the page

Hui's primary responsibilities will be:
- Calculate the number of votes for each of the question
- Transform the data into graph
- Give comprehensive view of the graph on the app

## Implementation Timeline

**Day 1**: Firebase/Swift user auth and start front end auth

**Day 2**: Swift models/views/controllers
            - Questions(Andrew)
            - Answers(Nathan)
            - Votes(Hui)

**Day 3**: Begin frontend
            - Questions(Andrew
            - Answers(Nathan)
            - Votes(Hui)

**Day 4**: Polish frontend
            - Questions(Andrew
            - Answers(Nathan)
            - Votes(Hui)

**Day 5**: Last touches/deploy

### Future Implementations
- Implement comments section for each of the questions
- Implement a search bar on news feed to allow user to search for question
- Create user profile dashboard
- Shared in facebook
- Marketing the app

## Plan for getting users and reviews
- Share on facebook and other social media.
- Create compelling questions when our app launches to provoke others to vote
