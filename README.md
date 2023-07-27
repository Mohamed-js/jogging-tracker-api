# Jogging Tracker Api

Jogging Tracker is an api for tracking or recording users' jogging times and distances. It Also gives some simple reports about their activity.

## Prerequesities

- Ruby 2.7.2 or higher
- Rails 6.1.7 or higher
- Node

```
You may want to change Ruby or Rails versions according to the ones you have on your machine.

Or, you can just change your Ruby version using Ruby Version Manager or URU or any other version manager of Ruby.
```

## Installation

1- Clone the repository:

```
git clone https://github.com/Mohamed-js/jogging-tracker-api.git
```

2- Enter the project directory:

```
cd jogging-tracker-api
```

3- Install all dependencies:

```
bundle install
```

4- Run database migrations:

```
rails db:migrate
```

5- Run the server:

```
rails s
```

6- Make RESTful api calls.

## Testing

1- Follow the previous steps then run:

```
rails db:migrate RAILS_ENV=test
```

2- Run this command:

```
rspec
```

Then you should see something like that:

```
Finished in 0.80157 seconds (files took 1.84 seconds to load)
26 examples, 0 failures
```

<hr>
<hr>
<hr>

## API DOCS and Call examples:

In the beginning, run:

```
rails db:seed
```

to generate the first Admin user, so that you can use it to make other users admins or user managers ;)

The email will be:
mohamedatef@gmail.com <br>
The password will be:
123123

Use them to login and get your token ;)

<hr>

In this project we have 5 resources:

1- registrations<br>
2- sessions<br>
3- users<br>
4- jogging_times<br>
5- reports<br>

### Registrations:

1- To create a new user.

```
POST '/api/v1/registrations'

body:
{
    email: "example@xyz.com",
    password: "6 letters word or more"
}
```

<hr>

### Sessions:

1- To login with a registered user.

```
POST '/api/v1/sessions'

body:
{
    email: "example@xyz.com",
    password: "6 letters word or more"
}
```

2- To logout with a registered user.

```
DELETE '/api/v1/sessions/:id'

Headers:
Authorization: Bearer <the token you got from login step>

```

<hr>

```
Note:
All the following requests should include Authorization header:

Authorization: Bearer <the token you got from login step>
```

<hr>

### Users:

1- List all users

```
GET '/api/v1/users'

```

2- Get a specfic user

```
GET '/api/v1/users/:id'

```

3- Create a new user

```
POST '/api/v1/users'

body:
{
    user: {
        email: 'example@xyz.com',
        password: "123123"
    }
}

```

4- Update a specific user

```
PUT '/api/v1/users/:id'

Accepted params:
{
    user: {
        email: 'example@xyz.com',
        password: "123123",
        role: <regular_user, user_manager, or admin>
    }
}

```

5- Delete a specific user

```
DELETE '/api/v1/users/:id'
```

<hr>

### Jogging Times:

1- List all jogging times

```
GET '/api/v1/jogging_times'

```

2- Get a specfic jogging time

```
GET '/api/v1/jogging_times/:id'

```

3- Create a new jogging time

```
POST '/api/v1/jogging_times'

body:
{
    jogging_time: {
        time: <numerical value>,
        distance: <decimal value>,
        date: <date value>
    }
}

```

4- Update a specific jogging time

```
PUT '/api/v1/jogging_times/:id'

Accepted params:
{
    jogging_time: {
        time: <numerical value>,
        distance: <decimal value>,
        date: <date value>
    }
}

```

5- Delete a specific jogging time

```
DELETE '/api/v1/jogging_times/:id'
```

<hr>

### Report on Jogging Times:

1- Show report of the current user << the one whose token is in the header >>

```
GET '/api/v1/reports'
```
