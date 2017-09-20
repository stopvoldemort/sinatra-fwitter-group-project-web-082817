User.create(username: "dave", email: "dave.gmail.com", password: "12345")
User.create(username: "jon", email: "jon.gmail.com", password: "abcde")
User.create(username: "elbin", email: "elbin.gmail.com", password: "a2c4e")

Tweet.create(content: "I'm dave", user_id: 1)
Tweet.create(content: "I'm jon", user_id: 2)
Tweet.create(content: "I'm elbin", user_id: 3)
