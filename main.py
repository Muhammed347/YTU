import tweepy
#from tweepy.streaming import StreamListener
from tweepy import Stream
import json
import pandas as pd

consumer_key = ''
consumer_secret = ''
access_token = ''
access_token_secret = ''

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, wait_on_rate_limit = True)


def scrape_user_friends(username):
    friends_scraped = []
    user = api.get_user(username)
    for i, _id in enumerate(tweepy.Cursor(api.friends_ids,
                                          screen_name = username).items()):
        print(i, _id)
        friends_scraped.append(_id)
    return friends_scraped

def scrape_user_followers(username):
    followers_scraped = []
    user = api.get_user(username)
    for i, _id in enumerate(tweepy.Cursor(api.followers_ids,
                                          screen_name = username).items()):
        print(i, _id)
        followers_scraped.append(_id)
    return followers_scraped

friends = scrape_user_friends('k_ristovski')
for i in range(len(friends)):
    screen_name = api.get_user(friends[i]).screen_name
    print(i, screen_name)