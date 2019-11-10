import pandas as pd
import string
df = pd.read_csv('./data/bars_review.csv')

custom_stop_words = []
with open( './data/stopwords.txt', "r" ) as fin:
    for line in fin.readlines():
        custom_stop_words.append( line.strip() )
# note that we need to make it hashable
print("Stopword list has %d entries" % len(custom_stop_words) )

from nltk.tokenize import sent_tokenize, word_tokenize
import re, string, unicodedata
import nltk
nltk.download('punkt')
nltk.download('wordnet')
import inflect
from bs4 import BeautifulSoup
from nltk import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from nltk.stem import LancasterStemmer, WordNetLemmatizer
from textblob import TextBlob
from langdetect import detect
from tqdm import tnrange as trange

def normalize(text):
  try:
    from_lng = detect(text)
  except:
    from_lng = "error"
  if from_lng != 'en':
    return('')
  p = inflect.engine()
  text = re.sub('[!”#$%&’\'()*+,-./:;<=>?@[\]^_`{|}~]', '', str(text))
  text = str(text.lower())
  words = word_tokenize(text)
  lemmatizer = WordNetLemmatizer()
  newwords = []
  for word in words:
    if word in custom_stop_words:
      continue
    if word.isdigit() == True:
      word = p.number_to_words(word)
    #newword = stemmer.stem(word)
    newword = lemmatizer.lemmatize(word, pos='v')
    newwords.append(newword)
  text = ' '.join(newwords)
  return text


new_texts = []
for i in trange(len(df['text'])):
    if i % 100000 == 0:
        print(i,' texts finished')
    if not df['text'][i]:
      new_texts.append(normalize(df['text'][i]))




df['text'] = new_texts
df.to_csv('./data/text_clean.csv')